import 'package:flutter/material.dart';
import '../models/address.dart';
import '../services/address_manager.dart';
import '../services/cart_manager.dart';
import '../utils/currency_formatter.dart';
import '../widgets/app_button.dart';
import '../models/order.dart';
import '../services/order_manager.dart';
import '../widgets/product_image.dart';

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

  double get subtotal {
    return CartManager.items.value.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  double get shippingCost {
    return subtotal > 0 ? 15000 : 0;
  }

  double get grandTotal {
    return subtotal + shippingCost;
  }

  Future<void> createOrder() async {
    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silahkan pilih alamat pengiriman')),
      );
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }
    final order = Order(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      items: List.from(CartManager.items.value),
      total: grandTotal,
      address: selectedAddress!.fullAddress,
      paymentMethod: selectedPaymentMethod!,
      createdAt: DateTime.now(),
    );

    await OrderManager.add(order);
    await CartManager.clear();

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContex) {
        return AlertDialog(
          title: const Text('Pensansn Berhasil'),
          content: const Text('Pesanan Anda berhasil dibuat'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContex);
              },
              child: const Text('Selesai'),
            ),
          ],
        );
      },
    );
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // final total = CartManager.items.value.fold<double>(
    //   0,
    //   (sum, item) => sum + item.totalPrice,
    // );

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
                'Checkout',
                style: TextStyle(fontSize: 26, fontWeight: .bold),
              ),
              const SizedBox(height: 16),
              buildAddressCard(context),
              const SizedBox(height: 16),
              buildProductCard(),
              const SizedBox(height: 16),
              buildPaymentCard(),
              const SizedBox(height: 16),
              buildPaymentSummary(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    const Text(
                      'Total pembayaran',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      CurrencyFormatter.format(grandTotal),
                      style: TextStyle(
                        fontWeight: .bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Buat Pesanan',
                  onPressed: createOrder,
                  icon: Icons.checklist_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Alamat Pengiriman',
                  style: TextStyle(fontSize: 16, fontWeight: .bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (selectedAddress == null)
              const Text('Belum ada alamat yang dipilih')
            else
              Text(
                '${selectedAddress!.label}\n'
                '${selectedAddress!.recipientName}\n'
                '${selectedAddress!.phone}\n'
                '${selectedAddress!.fullAddress}\n',
              ),
            const SizedBox(height: 8),
            Align(
              alignment: .centerRight,
              child: TextButton(
                onPressed: chooseAddress,
                child: Text(
                  selectedAddress == null ? 'Pilih Alamat' : 'Ganti Alamat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard() {
    final cartItems = CartManager.items.value;

    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text(
              'Produk yang Dibeli',
              style: TextStyle(fontSize: 16, fontWeight: .bold),
            ),
            const SizedBox(height: 12),
            ...cartItems.map((item) {
              return Padding(
                padding: const .only(bottom: 12),
                child: Row(
                  children: [
                    ProductImage(imageUrl: item.product.imageUrl, size: 72),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            item.product.name,
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: const TextStyle(fontWeight: .bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.quantity} x'
                            '${CurrencyFormatter.format(item.product.price)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentCard() {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text(
              'Metode Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: .bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: selectedPaymentMethod,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.paypal_outlined),
                border: OutlineInputBorder(borderRadius: .circular(12)),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Transfer Bank',
                  child: Text('Transfer Bank'),
                ),
                DropdownMenuItem(
                  value: 'Transfer E-Walet',
                  child: Text('Transfer E-Walet'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih metode pembaran';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          CurrencyFormatter.format(value),
          style: TextStyle(
            fontWeight: .bold,
            color: isTotal ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }

  Widget buildPaymentSummary() {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text(
              'Ringkasan Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: .bold),
            ),
            const SizedBox(height: 16),
            buildPriceRow('Total Produk', subtotal),
            const SizedBox(height: 8),
            buildPriceRow('Ongkos Kirim', shippingCost),
            const Divider(height: 24),
            buildPriceRow('Total Pembayaran', grandTotal, isTotal: true),
          ],
        ),
      ),
    );
  }
}
