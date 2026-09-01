import 'package:flutter/material.dart';
import 'package:new1/pages/edit_profile_page.dart';
import 'package:new1/services/auth_manager.dart';
import 'pages/address_page.dart';
import 'pages/login_page.dart';
import 'pages/favorite_page.dart';
import 'services/address_manager.dart';
import 'pages/register_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/order_detail_page.dart';
import 'pages/order_history_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/profile_page.dart';
import 'models/product.dart';
import 'models/order.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/main_navigation_page.dart';
import 'pages/product_image_viewer_page.dart';
import 'pages/otp_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID');
  await AuthManager.restoreSession();
  await AddressManager.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: const Color(0xFFF9F7FF),
      ),

      initialRoute: AuthManager.isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const MainNavigationPage(),
        '/register': (context) => const RegisterPage(),
        '/cart': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/orders': (context) => const OrderHistoryPage(),
        '/favorites': (context) => const FavoritePage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/addresses': (context) {
          final selectionMode =
              ModalRoute.of(context)?.settings.arguments as bool? ?? false;
          return AddressPage(selectionMode: selectionMode);
        },
        '/add-address': (context) => const AddAddressPage(),
        '/otp': (context) {
          final arguments =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>;
          return OtpPage(
            phoneNumber: arguments['phoneNumber'] as String,
            otpPair: arguments['otpPair'] as String,
          );
        },
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/product-detail') {
          final product = settings.arguments as Product;

          return MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(product: product);
            },
          );
        }
        if (settings.name == '/order-detail') {
          final order = settings.arguments as Order;

          return MaterialPageRoute(
            builder: (context) {
              return OrderDetailPage(order: order);
            },
          );
        }
        if (settings.name == '/image-viewer') {
          final arguments = settings.arguments as Map<String, dynamic>;
          final images = List<String>.from(arguments['images'] as List);
          final initialIndex = arguments['initialIndex'] as int? ?? 0;

          return MaterialPageRoute(
            builder: (context) {
              return ProductImageViewerPage(
                images: images,
                initialIndex: initialIndex,
              );
            },
          );
        }

        return null;
      },
    );
  }
}
