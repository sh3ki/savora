import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/recipe_model.dart';
import '../data/recipe_data.dart';
import '../widgets/app_logo.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String _query = '';
  RecipeCategory? _selectedCategory;

  List<Recipe> get _results {
    List<Recipe> list = _query.isNotEmpty ? RecipeData.search(_query) : RecipeData.recipes;
    if (_selectedCategory != null) {
      list = list.where((r) => r.category == _selectedCategory).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceAlt,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: AppLogo(size: 32, showText: false),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Recipe Studio',
                    style: GoogleFonts.playfairDisplay(
                      color: AppTheme.textPrimary,
                      fontSize: 31,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Search by ingredients, mood, or cuisine',
                    style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => _query = v),
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Try "spicy shrimp" or "dessert"',
                        hintStyle: GoogleFonts.dmSans(color: AppTheme.textSecondary),
                        border: InputBorder.none,
                        icon: const Icon(Icons.search_rounded, color: AppTheme.textSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _pill(null, 'All'),
                  ...RecipeData.allCategories.map((c) => _pill(c, c.label)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_results.length} recipes found',
                style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final recipe = _results[index];
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

  Widget _pill(RecipeCategory? cat, String label) {
    final selected = _selectedCategory == cat;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = cat),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppTheme.primary : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppTheme.primary : AppTheme.divider),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppTheme.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
