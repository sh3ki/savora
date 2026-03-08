import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavoriteToggle;
  final bool large;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavoriteToggle,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return large ? _LargeCard(recipe: recipe, onTap: onTap, onFavoriteToggle: onFavoriteToggle)
                 : _CompactCard(recipe: recipe, onTap: onTap, onFavoriteToggle: onFavoriteToggle);
  }
}

class _LargeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavoriteToggle;

  const _LargeCard({required this.recipe, this.onTap, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.categoryColors;
    final color = colors[recipe.category.colorIndex % colors.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [AppTheme.cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Center(child: Text(recipe.gradientEmoji, style: const TextStyle(fontSize: 60))),
                  Positioned(
                    top: 10, left: 10,
                    child: _CategoryBadge(label: recipe.category.label, emoji: recipe.category.emoji),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: _FavoriteButton(isFav: recipe.isFavorite, onToggle: onFavoriteToggle),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(recipe.description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _InfoChip(icon: Icons.timer_outlined, label: '${recipe.totalMinutes}m'),
                      const SizedBox(width: 8),
                      _InfoChip(icon: Icons.people_outline, label: '${recipe.servings}'),
                      const SizedBox(width: 8),
                      _InfoChip(icon: Icons.star_rounded, label: '${recipe.rating}', iconColor: Colors.amber),
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
}

class _CompactCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavoriteToggle;

  const _CompactCard({required this.recipe, this.onTap, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.categoryColors;
    final color = colors[recipe.category.colorIndex % colors.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppTheme.softShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.7), color.withOpacity(0.35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Center(child: Text(recipe.gradientEmoji, style: const TextStyle(fontSize: 40))),
                    Positioned(
                      top: 6, right: 6,
                      child: _FavoriteButton(isFav: recipe.isFavorite, onToggle: onFavoriteToggle, small: true),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 12, color: Colors.grey),
                        const SizedBox(width: 3),
                        Text('${recipe.totalMinutes}m', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        const Spacer(),
                        const Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${recipe.rating}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
}

class _CategoryBadge extends StatelessWidget {
  final String label, emoji;
  const _CategoryBadge({required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('$emoji $label', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFav;
  final ValueChanged<bool>? onToggle;
  final bool small;

  const _FavoriteButton({required this.isFav, this.onToggle, this.small = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle?.call(!isFav),
      child: Container(
        padding: EdgeInsets.all(small ? 4 : 6),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey, size: small ? 14 : 18),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _InfoChip({required this.icon, required this.label, this.iconColor = const Color(0xFF6B7280)});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: iconColor),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
      ],
    );
  }
}
