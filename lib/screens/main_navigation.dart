import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'browse_screen.dart';
import 'favorites_screen.dart';
import 'planner_screen.dart';
import 'stories_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    BrowseScreen(),
    PlannerScreen(),
    StoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  final _items = const [
    _NavItem('Home', Icons.home_rounded),
    _NavItem('Browse', Icons.search_rounded),
    _NavItem('Plan', Icons.event_note_rounded),
    _NavItem('Stories', Icons.auto_stories_rounded),
    _NavItem('Saved', Icons.favorite_rounded),
    _NavItem('Profile', Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: SizedBox(
          height: 76,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppTheme.cardShadow,
                  border: Border.all(color: AppTheme.divider.withOpacity(0.45)),
                ),
                child: Row(
                  children: List.generate(_items.length, (i) {
                    final selected = _currentIndex == i;
                    final item = _items[i];
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _currentIndex = i),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                gradient: selected ? AppTheme.heroGradient : null,
                                color: selected ? null : AppTheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item.icon,
                                size: 17,
                                color: selected ? Colors.white : AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                color: selected ? AppTheme.primary : AppTheme.textSecondary,
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;

  const _NavItem(this.label, this.icon);
}
