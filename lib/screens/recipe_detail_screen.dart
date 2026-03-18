import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.categoryColors[recipe.category.colorIndex % AppTheme.categoryColors.length];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.primary,
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.surfaceAlt),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 66,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recipe.category.label,
                        style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(recipe.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and description
                  Text(recipe.title, style: GoogleFonts.playfairDisplay(color: AppTheme.textPrimary, fontSize: 30, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(recipe.description, style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 14, height: 1.5)),
                  const SizedBox(height: 16),

                  // Tags
                  Row(
                    children: [
                      _tag(recipe.difficulty.label, color),
                      const SizedBox(width: 8),
                      ...recipe.tags.take(2).map((t) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _tag(t, AppTheme.textSecondary),
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Stats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Row(
                      children: [
                        _statItem(Icons.schedule_rounded, '${recipe.totalMinutes}', 'Minutes'),
                        Container(width: 1, height: 36, color: AppTheme.divider),
                        _statItem(Icons.people_rounded, '${recipe.servings}', 'Servings'),
                        Container(width: 1, height: 36, color: AppTheme.divider),
                        _statItem(Icons.local_fire_department_rounded, '${recipe.calories}', 'Calories'),
                        Container(width: 1, height: 36, color: AppTheme.divider),
                        _statItem(Icons.star_rounded, '${recipe.rating}', '${recipe.reviewCount} rev'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Ingredients
                  const Text('Ingredients', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(i, style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.textPrimary))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 28),

                  // Steps
                  const Text('Instructions', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  ...recipe.steps.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${e.key + 1}',
                              style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e.value, style: GoogleFonts.dmSans(fontSize: 14, height: 1.4, color: AppTheme.textPrimary))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),

                  // All tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: recipe.tags.map((t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(t, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    )).toList(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
          Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }
}
