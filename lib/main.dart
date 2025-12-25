import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart' as app_auth;
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/product_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => app_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Laza',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9775FA)),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String? _lastUserId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user != null) {
          final userId = user.uid;
          debugPrint('🔑 AuthWrapper: User authenticated with UID: $userId');
          
          if (userId != _lastUserId) {
            _lastUserId = userId;
            debugPrint('🔑 Setting userId in providers...');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                context.read<CartProvider>().setUserId(userId);
                context.read<FavoritesProvider>().setUserId(userId);
                debugPrint('✅ UserId set in CartProvider and FavoritesProvider');
              }
            });
          }
          return const HomeScreen();
        }
        debugPrint('🔑 AuthWrapper: No user authenticated');
        return const LoginScreen();
      },
    );
  }
}
