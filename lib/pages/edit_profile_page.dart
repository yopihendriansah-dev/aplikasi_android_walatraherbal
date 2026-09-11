import 'package:flutter/material.dart';
import 'package:new1/widgets/app_text_field.dart';
import '../services/auth_api_service.dart';
import '../services/auth_manager.dart';
import '../widgets/app_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    final user = AuthManager.currentUser.value;
    nameController = TextEditingController(text: user?.name ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final currentUser = AuthManager.currentUser.value;
    if (currentUser == null) {
      return;
    }

    final token = AuthManager.authToken;
    if (token == null || token.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final updatedUser = await AuthApiService.updateProfile(
        token: token,
        name: nameController.text.trim(),
      );
      await AuthManager.updateCurrentUser(updatedUser);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = error.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'Profil gagal disimpan';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                controller: nameController,
                hintText: 'Nama lengkap',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              AppButton(
                text: 'Simpan Perubahan',
                onPressed: saveProfile,
                icon: Icons.save_outlined,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
