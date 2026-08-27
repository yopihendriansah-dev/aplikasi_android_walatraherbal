import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_manager.dart';
import '../widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout(BuildContext context) async {
    final shouldlogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar dari akun?'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
    if (shouldlogout != true || !context.mounted) {
      return;
    }

    AuthManager.logout();

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Saya'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit profil',
          ),
        ],
      ),
      body: ValueListenableBuilder<User?>(
        valueListenable: AuthManager.currentUser,
        builder: (context, user, child) {
          if (user == null) {
            return const Center(child: Text('Belum ada pengguna yang login'));
          }

          final initial = user.name.isNotEmpty
              ? user.name[0].toUpperCase()
              : '?';
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  child: Text(
                    initial,
                    style: TextStyle(fontSize: 36, fontWeight: .bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 22, fontWeight: .bold),
                ),
                const SizedBox(height: 8),
                Text(user.email, style: TextStyle(color: Colors.grey)),
                const Spacer(),
                AppButton(
                  text: 'Logout',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  icon: Icons.logout,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
