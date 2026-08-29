import 'package:flutter/material.dart';
import '../models/address.dart';
import '../services/address_manager.dart';
import '../services/cart_manager.dart';
import '../utils/currency_formatter.dart';
import '../widgets/app_button.dart';
import '../models/order.dart';
import '../services/order_manager.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final formKey = GlobalKey<FormState>();
  String? selectedPaymentMethod;
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    selectedAddress = AddressManager.defaultAddress;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> chooseAddress() async {
    final result = await Navigator.pushNamed(
      context,
      '/addresses',
      arguments: true,
    );

    if (!mounted || result is! Address) {
      return;
    }

    setState(() {
      selectedAddress = result;
    });
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alamat Pengiriman',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (selectedAddress == null)
                        const Text('Belum ada alamat utama')
                      else
                        Text(
                          '${selectedAddress!.label}\n'
                          '${selectedAddress!.recipientName}\n'
                          '${selectedAddress!.phone}\n'
                          '${selectedAddress!.fullAddress}',
                        ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: chooseAddress,
                        icon: const Icon(Icons.edit_location_alt_outlined),
                        label: Text(
                          selectedAddress == null
                              ? 'Pilih Alamat'
                              : 'Ganti Alamat',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: selectedPaymentMethod,
                decoration: InputDecoration(
                  labelText: 'Metode Pembayaran',
                  prefixIcon: const Icon(Icons.paypal_outlined),
                  border: OutlineInputBorder(borderRadius: .circular(12)),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Transfer Bangk',
                    child: Text('Transfer Bank'),
                  ),
                  DropdownMenuItem(value: 'E-Walet', child: Text('E-Walet')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih metode pembayaran';
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

                onPressed: () async {
                  if (selectedAddress == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Silakan pilih alamat pengiriman'),
                      ),
                    );
                    return;
                  }

                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final order = Order(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    items: List.from(CartManager.items.value),
                    total: total,
                    address: selectedAddress!.fullAddress,
                    paymentMethod: selectedPaymentMethod!,
                    createdAt: DateTime.now(),
                  );

                  await OrderManager.add(order);
                  await CartManager.clear();

                  if (!context.mounted) {
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Pesanan Berhasil'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              CartManager.clear();
                              Navigator.pop(dialogContext);
                              Navigator.pop(context);
                            },
                            child: const Text('Selesai'),
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
    );
  }
}
