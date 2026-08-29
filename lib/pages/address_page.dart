import 'package:flutter/material.dart';

import '../models/address.dart';
import '../services/address_manager.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class AddressPage extends StatelessWidget {
  final bool selectionMode;

  const AddressPage({super.key, this.selectionMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Pengiriman')),

      body: ValueListenableBuilder<List<Address>>(
        valueListenable: AddressManager.addresses,
        builder: (context, addresses, child) {
          if (addresses.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    const Icon(Icons.location_off_outlined, size: 64),
                    const SizedBox(height: 12),
                    const Text(
                      'Belum ada alamat tersimpan',
                      textAlign: .center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 220,
                      child: AppButton(
                        text: 'Tambahkan Alamat',
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.pushNamed(context, '/add-address');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const .all(16),
                        onTap: selectionMode
                            ? () {
                                Navigator.pop(context, address);
                              }
                            : null,
                        leading: Icon(
                          address.isDefault
                              ? Icons.check_circle
                              : Icons.location_on_outlined,

                          color: address.isDefault
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),

                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                address.label,
                                style: const TextStyle(fontWeight: .bold),
                              ),
                            ),
                            if (address.isDefault)
                              const Chip(label: Text('Utama')),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${address.recipientName}\n'
                            '${address.phone}\n'
                            '${address.fullAddress}',
                          ),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'default') {
                              await AddressManager.setDefault(address.id);
                            }

                            if (value == 'delete') {
                              await AddressManager.delete(address.id);
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              if (!address.isDefault)
                                const PopupMenuItem(
                                  value: 'default',
                                  child: Text('Jadikan utama'),
                                ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Hapus'),
                              ),
                            ];
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const .all(16),
                child: AppButton(
                  text: 'Tambah Alamat',
                  icon: Icons.add,
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-address');
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final recipientController = TextEditingController();
  final phoneControler = TextEditingController();
  final addressController = TextEditingController();

  bool isDefault = false;

  @override
  void dispose() {
    labelController.dispose();
    recipientController.dispose();
    phoneControler.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> saveAddress() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final address = Address(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      label: labelController.text.trim(),
      recipientName: recipientController.text.trim(),
      phone: phoneControler.text.trim(),
      fullAddress: addressController.text.trim(),
      isDefault: isDefault,
    );

    await AddressManager.add(address);

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Alamat')),
      body: SingleChildScrollView(
        padding: const .all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                controller: labelController,
                hintText: 'Label alamat, contoh: Rumah',
                prefixIcon: Icons.label_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Label alamat wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              AppTextField(
                controller: recipientController,
                hintText: 'Nama penerima',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama penerima wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: phoneControler,
                hintText: 'Nomor telepon',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor telepon wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: addressController,
                hintText: 'Alamat lengkap',
                prefixIcon: Icons.location_on_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Alamat wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: .zero,
                title: const Text('Jadi alamat utama'),
                value: isDefault,
                onChanged: (value) {
                  setState(() {
                    isDefault = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Simpan Alamat',
                onPressed: saveAddress,
                icon: Icons.save_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
