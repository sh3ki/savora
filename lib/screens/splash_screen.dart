import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;
  late Animation<double> _tilt;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _scale = Tween<double>(begin: 0.84, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.85, curve: Curves.easeOutBack)),
    );
    _tilt = Tween<double>(begin: 0.03, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 1, curve: Curves.easeOut)),
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MainNavigation(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
          ),
          Positioned(
            top: -120,
            left: -80,
            child: _orb(260, Colors.white.withOpacity(0.10)),
          ),
          Positioned(
            right: -100,
            bottom: -80,
            child: _orb(240, Colors.black.withOpacity(0.10)),
          ),
          Positioned.fill(
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _tilt.value,
                          child: Transform.scale(scale: _scale.value, child: child),
                        );
                      },
                      child: const AppLogo(size: 92, showText: false, withFrame: false),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'SAVORA',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 44,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Where flavor becomes art',
                      style: GoogleFonts.dmSans(
                        color: Colors.white.withOpacity(0.88),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: _buildFeatures(),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 34),
                      child: SizedBox(
                        width: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const LinearProgressIndicator(
                            minHeight: 6,
                            backgroundColor: Color(0x44FFFFFF),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  List<Widget> _buildFeatures() {
    final features = [
      (Icons.ramen_dining_rounded, 'Plate'),
      (Icons.local_fire_department_rounded, 'Sear'),
      (Icons.room_service_rounded, 'Serve'),
    ];
    return features
        .map(
          (f) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.24)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(f.$1, size: 15, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  f.$2,
                  style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
