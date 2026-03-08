import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _metricUnits = true;
  bool _showCalories = true;

  @override
  Widget build(BuildContext context) {
    final favorites = MockData.recipes.where((r) => r.isFavorite).length;
    final categories = MockData.allCategories.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.primary,
            title: const Text('Profile', style: TextStyle(color: Colors.white, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppTheme.heroGradient),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Center(child: Text('👨‍🍳', style: TextStyle(fontSize: 40))),
                      ),
                      const SizedBox(height: 10),
                      const Text('Jordan Chef', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'PlayfairDisplay')),
                      const Text('Home Cook Enthusiast', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [AppTheme.softShadow],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatBox(value: '${MockData.recipes.length}', label: 'Recipes'),
                        _Divider(),
                        _StatBox(value: '$favorites', label: 'Favorites'),
                        _Divider(),
                        _StatBox(value: '$categories', label: 'Categories'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preferences
                  _SectionTitle('Preferences'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [AppTheme.softShadow],
                    ),
                    child: Column(
                      children: [
                        _Toggle(
                          icon: Icons.notifications_outlined, label: 'Recipe Notifications',
                          value: _notificationsEnabled, onChanged: (v) => setState(() => _notificationsEnabled = v),
                        ),
                        _Separator(),
                        _Toggle(
                          icon: Icons.straighten_outlined, label: 'Metric Units',
                          value: _metricUnits, onChanged: (v) => setState(() => _metricUnits = v),
                        ),
                        _Separator(),
                        _Toggle(
                          icon: Icons.local_fire_department_outlined, label: 'Show Calories',
                          value: _showCalories, onChanged: (v) => setState(() => _showCalories = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // App settings
                  _SectionTitle('App'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [AppTheme.softShadow],
                    ),
                    child: Column(
                      children: [
                        _MenuItem(icon: Icons.star_rate_outlined, label: 'Rate Savora', onTap: () {}),
                        _Separator(),
                        _MenuItem(icon: Icons.share_outlined, label: 'Share with Friends', onTap: () {}),
                        _Separator(),
                        _MenuItem(icon: Icons.help_outline, label: 'Help & Support', onTap: () {}),
                        _Separator(),
                        _MenuItem(icon: Icons.info_outline, label: 'About', onTap: () => _showAbout(context)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Version badge
                  Center(
                    child: Column(
                      children: [
                        const Text('👨‍🍳', style: TextStyle(fontSize: 28)),
                        const SizedBox(height: 6),
                        Text('Savora v1.0.0', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        Text('Made with ❤️ for food lovers', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('About Savora', style: TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700)),
        content: const Text('Savora is your personal recipe companion — discover, cook, and savor delicious meals from around the world. Crafted with love for home cooks everywhere.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value, label;
  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.primary)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 40, color: Colors.grey[200]);
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Divider(height: 1, indent: 16, endIndent: 16, color: Colors.grey[100]);
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'PlayfairDisplay'));
  }
}

class _Toggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _Toggle({required this.icon, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Switch(value: value, onChanged: onChanged, activeColor: AppTheme.primary),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
