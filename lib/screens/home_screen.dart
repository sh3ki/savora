import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/recipe_model.dart';
import '../data/recipe_data.dart';
import '../widgets/app_logo.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecipeCategory? _selectedCategory;

  List<Recipe> get _filteredRecipes {
    if (_selectedCategory == null) return RecipeData.recipes;
    return RecipeData.byCategory(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFAF4), AppTheme.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _heroHeader(),
              const SizedBox(height: 22),
              _sectionTitle('Featured Recipes', 'Today\'s chef picks'),
              const SizedBox(height: 14),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: RecipeData.featuredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = RecipeData.featuredRecipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      isLarge: true,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe))),
                      onFavorite: () => setState(() => recipe.isFavorite = !recipe.isFavorite),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Browse by Mood', 'Pick a flavor profile'),
              const SizedBox(height: 12),
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _categoryChip(null, 'All'),
                    ...RecipeData.allCategories.map((c) => _categoryChip(c, c.label)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.74,
                ),
                itemCount: _filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = _filteredRecipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe))),
                    onFavorite: () => setState(() => recipe.isFavorite = !recipe.isFavorite),
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.spice],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppLogo(size: 44, showText: false),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Savora Kitchen',
                  style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              const Icon(Icons.tune_rounded, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Cook bold\nEat beautifully',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 36,
              height: 1.05,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover global recipes with real ingredients and chef-level guidance.',
            style: GoogleFonts.dmSans(color: Colors.white.withOpacity(0.88), height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _categoryChip(RecipeCategory? cat, String label) {
    final selected = _selectedCategory == cat;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _selectedCategory = cat),
        backgroundColor: Colors.white,
        selectedColor: AppTheme.primary,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppTheme.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: selected ? AppTheme.primary : AppTheme.divider),
        ),
      ),
    );
  }
}
