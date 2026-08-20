import 'package:flutter/material.dart';
import 'package:new1/widgets/app_button.dart';

import '../widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmpassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const Text(
                  "Buat akun baru",
                  style: TextStyle(fontSize: 28, fontWeight: .bold),
                ),
                const SizedBox(height: 24),
                const Text('Nama', style: TextStyle(fontWeight: .w600)),
                const SizedBox(height: 8),
                AppTextField(
                  controller: nameController,
                  hintText: 'Masukan nama kamu',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                const Text('Email', style: TextStyle(fontWeight: .w600)),
                const SizedBox(height: 8),
                AppTextField(
                  controller: emailController,
                  hintText: 'Masukan email kamu',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Format email belum benar';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Password', style: TextStyle(fontWeight: .w600)),
                const SizedBox(height: 8),
                AppTextField(
                  controller: passwordController,
                  hintText: "Masukan password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Konfirmasi Password',
                  style: TextStyle(fontWeight: .w600),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: confirmPasswordController,
                  hintText: "Ulangi password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscureConfirmpassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmpassword = !obscureConfirmpassword;
                      });
                    },
                    icon: Icon(
                      obscureConfirmpassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value != passwordController.text) {
                      return 'Password tidak sama';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: "Daftar",
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pendaftaran Berhasil'),
                          content: const Text('Akun kamu berhasil dibuat'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Kembali ke Login '),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
