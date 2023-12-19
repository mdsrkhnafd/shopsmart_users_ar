import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsmart_users_ar/providers/cart_provider.dart';
import 'package:shopsmart_users_ar/providers/order_provider.dart';
import 'package:shopsmart_users_ar/providers/product_provider.dart';
import 'package:shopsmart_users_ar/providers/theme_provider.dart';
import 'package:shopsmart_users_ar/providers/user_provider.dart';
import 'package:shopsmart_users_ar/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users_ar/providers/wishlist_provider.dart';
import 'package:shopsmart_users_ar/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart_users_ar/screens/onboarding/introduction_screen.dart';
import 'package:shopsmart_users_ar/screens/search_screen.dart';
import 'package:shopsmart_users_ar/screens/splash_screen.dart';

import 'consts/theme_data.dart';
import 'root_screen.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screens/orders/orders_screen.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/wishlist.dart';


bool show = true;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedRecentlyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
          context,
          themeProvider,
          child,
          ) {
        return MaterialApp(
          title: 'Shop Smart AR',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: show ? const SplashScreen() : const RootScreen(),
          // home: const RegisterScreen(),
          routes: {
            RootScreen.routeName: (context) => const RootScreen(),
            ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) =>
            const ViewedRecentlyScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            LoginScreen.routName: (context) => const LoginScreen(),
            OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
            ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
          },
        );
      }),
    );

  }
}
