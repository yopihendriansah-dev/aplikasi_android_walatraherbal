import 'package:flutter/material.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';
import '../models/user.dart';
import '../services/auth_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Selamat datang",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Silahkan masuk untuk melanjutkan ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: emailController,
                  hintText: "Masukan email kamu",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email wajib diisi";
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return "Format email tidak valid";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: passwordController,
                  hintText: "Masukan password kamu",
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password wajib diisi";
                    }
                    if (value.length < 6) {
                      return "Password minimal 6 karakter";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur lupa password belum tersedia'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text('Lupa password?'),
                  ),
                ),
                const SizedBox(height: 24),

                AppButton(
                  text: 'Masuk',
                  isLoading: isLoading,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    await Future.delayed(const Duration(seconds: 2));
                    if (!context.mounted) return;

                    setState(() {
                      isLoading = false;
                    });

                    final user = User(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: emailController.text.trim().split('@').first,
                      email: emailController.text.trim(),
                    );

                    AuthManager.login(user);

                    setState(() {
                      isLoading = true;
                    });

                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("Daftar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
