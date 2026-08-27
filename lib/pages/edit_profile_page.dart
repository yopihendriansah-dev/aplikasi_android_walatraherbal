import 'package:flutter/material.dart';
import 'package:new1/widgets/app_text_field.dart';
import '../models/user.dart';
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
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    final user = AuthManager.currentUser.value;
    nameController = TextEditingController(text: user?.name ?? '');

    emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final currentUser = AuthManager.currentUser.value;
    if (currentUser == null) {
      return;
    }

    final updateUser = User(
      id: currentUser.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
    );

    AuthManager.login(updateUser);

    Navigator.pop(context);
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
              const SizedBox(height: 16),
              AppTextField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Simpan Perubahan',
                onPressed: saveProfile,
                icon: Icons.save_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
