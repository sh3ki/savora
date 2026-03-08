import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final _searchCtrl = TextEditingController();
  RecipeCategory? _selected;
  String _query = '';

  List<Recipe> get _results {
    List<Recipe> base = _selected != null
        ? MockData.byCategory(_selected!)
        : List.from(MockData.recipes);
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      base = base.where((r) => r.title.toLowerCase().contains(q) ||
          r.tags.any((t) => t.toLowerCase().contains(q))).toList();
    }
    return base;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      appBar: AppBar(
        title: const Text('Browse Recipes', style: TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'Search recipes, tags...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() { _query = ''; _searchCtrl.clear(); }))
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 12),
                // Category pills
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _Pill(label: 'All', selected: _selected == null, onTap: () => setState(() => _selected = null)),
                      ...MockData.allCategories.map((cat) => _Pill(
                        label: '${cat.emoji} ${cat.label}',
                        selected: _selected == cat,
                        onTap: () => setState(() => _selected = _selected == cat ? null : cat),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('No recipes found', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${_results.length} recipes', style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 12),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.78,
                            ),
                            itemCount: _results.length,
                            itemBuilder: (_, i) {
                              final r = _results[i];
                              return RecipeCard(
                                recipe: r,
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: r))),
                                onFavoriteToggle: (_) => setState(() { r.isFavorite = !r.isFavorite; }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : Colors.grey[700])),
      ),
    );
  }
}
