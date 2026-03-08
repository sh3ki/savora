import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
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
    if (_selectedCategory == null) return MockData.recipes;
    return MockData.byCategory(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    final featured = MockData.featuredRecipes;
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? 'Good Morning' : hour < 17 ? 'Good Afternoon' : 'Good Evening';

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppTheme.heroGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$greeting, Chef! 👋',
                            style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 6),
                        const Text('What are you cooking\ntoday?',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700, height: 1.2)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Section
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('✨ Featured', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'PlayfairDisplay')),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, right: 4),
                    itemCount: featured.length,
                    itemBuilder: (_, i) => RecipeCard(
                      recipe: featured[i],
                      large: true,
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: featured[i]))),
                      onFavoriteToggle: (_) => setState(() {
                        featured[i].isFavorite = !featured[i].isFavorite;
                      }),
                    ),
                  ),
                ),

                // Category Filter
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('Browse by Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'PlayfairDisplay')),
                ),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _CategoryChip(
                        label: 'All', emoji: '🍽️',
                        selected: _selectedCategory == null,
                        onTap: () => setState(() => _selectedCategory = null),
                      ),
                      ...MockData.allCategories.map((cat) => _CategoryChip(
                        label: cat.label, emoji: cat.emoji,
                        selected: _selectedCategory == cat,
                        onTap: () => setState(() => _selectedCategory = (_selectedCategory == cat) ? null : cat),
                      )),
                    ],
                  ),
                ),

                // Recipes Grid
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('All Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'PlayfairDisplay')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: _filteredRecipes.length,
                    itemBuilder: (_, i) {
                      final r = _filteredRecipes[i];
                      return RecipeCard(
                        recipe: r,
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(recipe: r))),
                        onFavoriteToggle: (_) => setState(() { r.isFavorite = !r.isFavorite; }),
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
  }
}

class _CategoryChip extends StatelessWidget {
  final String label, emoji;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({required this.label, required this.emoji, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: selected ? [AppTheme.softShadow] : [],
        ),
        child: Text(
          '$emoji $label',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : Colors.grey[700]),
        ),
      ),
    );
  }
}
