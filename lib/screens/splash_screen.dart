import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _mainController.forward();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      context.read<CartProvider>().setUserId(user.uid);
      context.read<FavoritesProvider>().setUserId(user.uid);
    }
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            user != null ? const HomeScreen() : const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
              Color(0xFF533483),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            ...List.generate(5, (index) => _buildFloatingCircle(index)),
            
            // Main content
            Center(
              child: AnimatedBuilder(
                animation: _mainController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with glow effect
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFD700),
                                        Color(0xFFFFA500),
                                        Color(0xFFFF8C00),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
                                        blurRadius: 50,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'L',
                                      style: TextStyle(
                                        fontSize: 72,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black26,
                                            offset: Offset(2, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Brand name with slide animation
                        Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFFFFFFFF),
                                Color(0xFFFFD700),
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'LAZA',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Tagline
                        Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: Text(
                            'Premium Shopping Experience',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withValues(alpha: 0.7),
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        
                        // Loading indicator
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white.withValues(alpha: 0.3),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: const Duration(seconds: 3),
                                  builder: (context, value, child) {
                                    return SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value: value,
                                        valueColor: const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFFD700),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCircle(int index) {
    final random = math.Random(index);
    final size = 100.0 + random.nextDouble() * 200;
    final left = random.nextDouble() * MediaQuery.of(context).size.width;
    final top = random.nextDouble() * MediaQuery.of(context).size.height;
    final duration = 3000 + random.nextInt(2000);

    return Positioned(
      left: left,
      top: top,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: duration),
        builder: (context, value, child) {
          return Opacity(
            opacity: 0.1 * value,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF9775FA).withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
