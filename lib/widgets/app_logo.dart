import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool lightText;
  final bool withFrame;

  const AppLogo({
    super.key,
    this.size = 48,
    this.showText = true,
    this.lightText = false,
    this.withFrame = true,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      width: size * 2.7,
      height: size,
      decoration: BoxDecoration(
        color: withFrame ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(size * 0.24),
        border: withFrame ? Border.all(color: AppTheme.divider) : null,
        boxShadow: withFrame ? AppTheme.cardShadow : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size * 0.12,
          vertical: size * 0.08,
        ),
        child: Image.asset(
          'assets/images/savora logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo,
        if (showText) ...[
          SizedBox(width: size * 0.25),
          Text(
            'Savora',
            style: TextStyle(
              color: lightText ? Colors.white : AppTheme.textPrimary,
              fontSize: size * 0.42,
              fontWeight: FontWeight.w700,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily,
            ),
          ),
        ],
      ],
    );
  }
}

class RecipeIcon extends StatelessWidget {
  final IconData icon;
  final int colorIndex;
  final double size;

  const RecipeIcon({
    super.key,
    required this.icon,
    required this.colorIndex,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.categoryColors[colorIndex % AppTheme.categoryColors.length];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
