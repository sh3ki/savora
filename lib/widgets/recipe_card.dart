import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isLarge;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.isLarge = false,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return isLarge ? _buildLargeCard() : _buildCompactCard();
  }

  Widget _buildLargeCard() {
    final color = AppTheme.categoryColors[recipe.category.colorIndex % AppTheme.categoryColors.length];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _webImage(recipe.imageUrl),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _favoriteButton(),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          recipe.category.label,
                          style: GoogleFonts.dmSans(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, color: AppTheme.textSecondary, size: 14),
                      const SizedBox(width: 4),
                      Text('${recipe.totalMinutes} min', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 12)),
                      const SizedBox(width: 12),
                      const Icon(Icons.star_rounded, color: AppTheme.secondary, size: 14),
                      const SizedBox(width: 2),
                      Text('${recipe.rating}', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _webImage(recipe.imageUrl),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _favoriteButton(small: true),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, height: 1.2),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.schedule_rounded, color: AppTheme.textSecondary, size: 12),
                        const SizedBox(width: 3),
                        Text('${recipe.totalMinutes}m', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 11)),
                        const Spacer(),
                        const Icon(Icons.star_rounded, color: AppTheme.secondary, size: 12),
                        const SizedBox(width: 2),
                        Text('${recipe.rating}', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton({bool small = false}) {
    return GestureDetector(
      onTap: onFavorite,
      child: Container(
        width: small ? 28 : 32,
        height: small ? 28 : 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          recipe.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: recipe.isFavorite ? AppTheme.primary : AppTheme.textSecondary,
          size: small ? 16 : 18,
        ),
      ),
    );
  }

  Widget _webImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppTheme.surfaceAlt,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: AppTheme.surfaceAlt,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_rounded, color: AppTheme.textSecondary),
        );
      },
    );
  }
}
