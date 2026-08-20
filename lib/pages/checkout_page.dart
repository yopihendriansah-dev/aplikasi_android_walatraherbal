import 'package:flutter/material.dart';

import '../services/cart_manager.dart';
import '../utils/currency_formatter.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = CartManager.items.value.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Text(
                'Alamat Pengiriman',
                style: TextStyle(fontSize: 22, fontWeight: .bold),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: addressController,
                hintText: "Masukan alamat lengkap",
                prefixIcon: Icons.location_on_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Alamat wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text(
                    'Total Pesanan',
                    style: TextStyle(fontSize: 18, fontWeight: .bold),
                  ),
                  Text(
                    CurrencyFormatter.format(total),
                    style: const TextStyle(fontSize: 18, fontWeight: .bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Buat Pesanan',

                icon: Icons.check_circle_outline,

                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan berhasil dibuat')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
