import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoCtrl, _textCtrl, _featuresCtrl;
  late Animation<double> _logoScale, _logoOpacity, _textOpacity, _textSlide, _featuresOpacity;

  @override
  void initState() {
    super.initState();
    _logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _textCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _featuresCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(_logoCtrl);
    _logoScale   = Tween<double>(begin: 0.3, end: 1).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(_textCtrl);
    _textSlide   = Tween<double>(begin: 30, end: 0).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _featuresOpacity = Tween<double>(begin: 0, end: 1).animate(_featuresCtrl);

    Future.microtask(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      _logoCtrl.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      _textCtrl.forward();
      await Future.delayed(const Duration(milliseconds: 400));
      _featuresCtrl.forward();
      await Future.delayed(const Duration(milliseconds: 1600));
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose(); _textCtrl.dispose(); _featuresCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.heroGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoCtrl,
                  builder: (_, __) => Opacity(
                    opacity: _logoOpacity.value.clamp(0, 1),
                    child: Transform.scale(
                      scale: _logoScale.value,
                      child: Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const Center(child: Text('👨‍🍳', style: TextStyle(fontSize: 56))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _textCtrl,
                  builder: (_, __) => Opacity(
                    opacity: _textOpacity.value.clamp(0, 1),
                    child: Transform.translate(
                      offset: Offset(0, _textSlide.value),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(text: 'Sav', style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 44, fontWeight: FontWeight.w700, color: Colors.white)),
                              TextSpan(text: 'ora', style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 44, fontWeight: FontWeight.w400, color: Colors.white70)),
                            ]),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Discover. Cook. Savor.',
                            style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                AnimatedBuilder(
                  animation: _featuresCtrl,
                  builder: (_, __) => Opacity(
                    opacity: _featuresOpacity.value.clamp(0, 1),
                    child: Column(
                      children: const [
                        _FeatureItem(emoji: '🍽️', label: '1,000+ Delicious Recipes'),
                        SizedBox(height: 12),
                        _FeatureItem(emoji: '🗂️', label: '8 Culinary Categories'),
                        SizedBox(height: 12),
                        _FeatureItem(emoji: '❤️', label: 'Save Your Favorites'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String emoji, label;
  const _FeatureItem({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
