import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Saya')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
            const SizedBox(height: 16),
            const Text(
              'Andi Setiawan',
              style: TextStyle(fontSize: 22, fontWeight: .bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'andisetiawan@mail.com',
              style: TextStyle(color: Colors.grey),
            ),
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
      ),
    );
  }
}
