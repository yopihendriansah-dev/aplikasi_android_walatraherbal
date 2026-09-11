import 'package:flutter/material.dart';

import 'login_page.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../services/auth_manager.dart';
import '../services/order_manager.dart';
import '../widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar dari akun?'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
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

    if (result != true || !context.mounted) {
      return;
    }

    try {
      await AuthManager.logout();
    } catch (error) {
      debugPrint('Logout lokal gagal: $error');
    }

    if (!context.mounted) {
      return;
    }

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profil Saya'),
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
          return ValueListenableBuilder<List<Order>>(
            valueListenable: OrderManager.orders,
            builder: (context, orders, child) {
              final unpaid = orders
                  .where((order) => order.status == 'Belum Bayar')
                  .length;

              final processing = orders
                  .where((order) => order.status == 'Diproses')
                  .length;
              final completed = orders
                  .where((order) => order.status == 'Selesai')
                  .length;

              final initial = user.name.isNotEmpty
                  ? user.name[0].toUpperCase()
                  : '?';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (AuthManager.requiresProfileCompletion)
                      const _IncompleteProfileCard(),
                    // header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(28),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.white,
                            child: Text(
                              initial,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: .bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: .bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email ?? user.phone,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // padding status
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              _OrderStatusItem(
                                icon: Icons.account_balance_wallet_outlined,
                                label: 'Belum Bayar',
                                count: unpaid,
                              ),
                              _OrderStatusItem(
                                icon: Icons.inventory_2_outlined,
                                label: 'Diproses',
                                count: processing,
                              ),
                              _OrderStatusItem(
                                icon: Icons.check_circle_outline,
                                label: 'Selesai',
                                count: completed,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // menu section akun saya
                    _MenuSection(
                      title: 'Akun Saya',
                      children: [
                        _MenuTile(
                          icon: Icons.person_outline,
                          title: 'Edit Profile',
                          ontap: () {
                            Navigator.pushNamed(context, '/edit-profile');
                          },
                        ),
                        _MenuTile(
                          icon: Icons.location_on_outlined,
                          title: 'Alamat Pengiriman',
                          ontap: () {
                            Navigator.pushNamed(context, '/addresses');
                          },
                        ),
                      ],
                    ),

                    // Menu Secttion bantuan
                    _MenuSection(
                      title: 'Bantuan dan Pengaturan',
                      children: [
                        _MenuTile(
                          icon: Icons.settings_outlined,
                          title: 'Pengaturan',
                          ontap: () {},
                        ),
                        _MenuTile(
                          icon: Icons.help_outline,
                          title: 'Pusat Bantuan',
                          ontap: () {},
                        ),
                        _MenuTile(
                          icon: Icons.info_outline,
                          title: 'Tentang Aplikasi',
                          ontap: () {},
                        ),
                      ],
                    ),
                    // tombol logout
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppButton(
                        text: 'Logout',
                        onPressed: () {
                          logout(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _IncompleteProfileCard extends StatelessWidget {
  const _IncompleteProfileCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('Profil belum lengkap'),
        subtitle: const Text('Tambahkan nama Anda untuk melengkapi profil.'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, '/edit-profile'),
      ),
    );
  }
}

class _OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _OrderStatusItem({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: const TextStyle(fontWeight: .bold, fontSize: 16),
          ),
          Text(label, textAlign: .center, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _MenuSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: const TextStyle(fontWeight: .bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(child: Column(children: children)),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: ontap,
    );
  }
}
