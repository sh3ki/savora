import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final colors = AppTheme.categoryColors;
    final color = colors[r.category.colorIndex % colors.length];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: color,
            leading: BackButton(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(r.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                onPressed: () => setState(() => r.isFavorite = !r.isFavorite),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Text(r.gradientEmoji, style: const TextStyle(fontSize: 90))),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title area
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _Tag(text: '${r.category.emoji} ${r.category.label}'),
                          const SizedBox(width: 8),
                          _Tag(text: r.difficulty.label, isDifficulty: true),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(r.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(r.description, style: TextStyle(color: Colors.grey[600], height: 1.5)),
                    ],
                  ),
                ),

                // Stats row
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppTheme.softShadow],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Stat(icon: Icons.timer_outlined, label: 'Total Time', value: '${r.totalMinutes}m'),
                      _VertDivider(),
                      _Stat(icon: Icons.people_outline, label: 'Servings', value: '${r.servings}'),
                      _VertDivider(),
                      _Stat(icon: Icons.local_fire_department_outlined, label: 'Calories', value: '${r.calories}'),
                      _VertDivider(),
                      _Stat(icon: Icons.star_rounded, label: 'Rating', value: '${r.rating}', iconColor: Colors.amber),
                    ],
                  ),
                ),

                // Prep / Cook time
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppTheme.softShadow],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _TimeDetail(label: 'Prep Time', value: '${r.prepMinutes} min')),
                      const SizedBox(width: 16),
                      Expanded(child: _TimeDetail(label: 'Cook Time', value: '${r.cookMinutes} min')),
                    ],
                  ),
                ),

                // Tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppTheme.softShadow],
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabCtrl,
                        indicatorColor: AppTheme.primary,
                        labelColor: AppTheme.primary,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [Tab(text: 'Ingredients'), Tab(text: 'Steps')],
                      ),
                      SizedBox(
                        height: (r.steps.length > r.ingredients.length ? r.steps.length : r.ingredients.length) * 56.0 + 40,
                        child: TabBarView(
                          controller: _tabCtrl,
                          children: [
                            _IngredientsList(ingredients: r.ingredients),
                            _StepsList(steps: r.steps),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Tags
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 8,
                    children: r.tags.map((t) => Chip(
                      label: Text(t),
                      backgroundColor: AppTheme.primary.withOpacity(0.1),
                      labelStyle: TextStyle(color: AppTheme.primary, fontSize: 12),
                    )).toList(),
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

class _Tag extends StatelessWidget {
  final String text;
  final bool isDifficulty;
  const _Tag({required this.text, this.isDifficulty = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDifficulty ? AppTheme.secondary.withOpacity(0.15) : AppTheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDifficulty ? AppTheme.secondary : AppTheme.primary)),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color iconColor;

  const _Stat({required this.icon, required this.label, required this.value, this.iconColor = const Color(0xFF6B7280)});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 40, color: Colors.grey[200]);
}

class _TimeDetail extends StatelessWidget {
  final String label, value;
  const _TimeDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.primary, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class _IngredientsList extends StatelessWidget {
  final List<String> ingredients;
  const _IngredientsList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ingredients.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(ingredients[i], style: const TextStyle(height: 1.3))),
          ],
        ),
      ),
    );
  }
}

class _StepsList extends StatelessWidget {
  final List<String> steps;
  const _StepsList({required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(gradient: AppTheme.heroGradient, borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(steps[i], style: const TextStyle(height: 1.5))),
          ],
        ),
      ),
    );
  }
}
