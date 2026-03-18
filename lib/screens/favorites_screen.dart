import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/recipe_data.dart';
import '../widgets/app_logo.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = RecipeData.favoriteRecipes;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your Saved Menu',
                      style: GoogleFonts.playfairDisplay(color: AppTheme.textPrimary, fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const AppLogo(size: 34, showText: false),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${favorites.length} saved recipes',
                style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.spice],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite_rounded, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Build your dream cookbook from these picks.',
                        style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: favorites.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite_border_rounded, color: AppTheme.textSecondary.withOpacity(0.4), size: 56),
                          const SizedBox(height: 12),
                          Text('No favorites yet', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('Tap the heart icon to save recipes', style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 13)),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final recipe = favorites[index];
                        return RecipeCard(
                          recipe: recipe,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe))),
                          onFavorite: () => setState(() => recipe.isFavorite = !recipe.isFavorite),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
