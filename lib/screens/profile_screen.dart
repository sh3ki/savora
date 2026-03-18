import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/recipe_data.dart';
import '../widgets/app_logo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _metric = false;
  bool _showCalories = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Chef Profile',
              style: GoogleFonts.playfairDisplay(
                color: AppTheme.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),

            // Profile card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.spice],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jordan Chef', style: GoogleFonts.dmSans(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text('Home Cook Enthusiast', style: GoogleFonts.dmSans(color: Colors.white.withOpacity(0.84), fontSize: 13)),
                      ],
                    ),
                  ),
                  Icon(Icons.edit_rounded, color: Colors.white.withOpacity(0.6), size: 20),
                ],
              ),
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
                  _stat('${RecipeData.recipes.length}', 'Recipes'),
                  Container(width: 1, height: 36, color: AppTheme.divider),
                  _stat('${RecipeData.favoriteRecipes.length}', 'Favorites'),
                  Container(width: 1, height: 36, color: AppTheme.divider),
                  _stat('${RecipeData.allCategories.length}', 'Categories'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Preferences
            _sectionLabel('Preferences'),
            _switchTile(Icons.notifications_none_rounded, 'Notifications', _notifications, (v) => setState(() => _notifications = v)),
            _switchTile(Icons.straighten_rounded, 'Metric Units', _metric, (v) => setState(() => _metric = v)),
            _switchTile(Icons.local_fire_department_rounded, 'Show Calories', _showCalories, (v) => setState(() => _showCalories = v)),
            const SizedBox(height: 20),
            _sectionLabel('Top Community Profiles'),
            const SizedBox(height: 8),
            _profileRow('Maya Chen', 'Pastry Artist', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=500&q=80'),
            _profileRow('Diego Alvarez', 'Street Food Expert', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=80'),
            _profileRow('Nadia Noor', 'Plant-Based Chef', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=500&q=80'),
            const SizedBox(height: 20),

            // Menu
            _sectionLabel('App'),
            _menuTile(Icons.star_outline_rounded, 'Rate App'),
            _menuTile(Icons.share_outlined, 'Share App'),
            _menuTile(Icons.help_outline_rounded, 'Help Center'),
            _menuTile(Icons.info_outline_rounded, 'About'),
            const SizedBox(height: 24),

            // Footer
            Center(
              child: Column(
                children: [
                  const AppLogo(size: 28, showText: true),
                  const SizedBox(height: 6),
                  Text('Version 1.0.0', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.6), fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }

  Widget _switchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700))),
          Switch(value: value, onChanged: onChanged, activeColor: AppTheme.primary),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700))),
          const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary, size: 20),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: GoogleFonts.dmSans(color: AppTheme.primary, fontSize: 18, fontWeight: FontWeight.w700)),
          Text(label, style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _profileRow(String name, String role, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                Text(role, style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text('View', style: GoogleFonts.dmSans(color: AppTheme.primary, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
