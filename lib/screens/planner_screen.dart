import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF7EE), Color(0xFFF9E8D6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: AppLogo(size: 34, showText: false),
              ),
              const SizedBox(height: 6),
              Text(
                'Weekly Planner',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Curated meal flow for your kitchen rhythm.',
                style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 22),
              _highlightCard(),
              const SizedBox(height: 18),
              ..._days().map(_dayCard),
            ],
          ),
        ),
      ),
    );
  }

  Widget _highlightCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.spice],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_note_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Chef Focus Plan',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Balanced Week\n14 planned dishes',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _badge('Prep 2h'),
              const SizedBox(width: 8),
              _badge('Budget Smart'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayCard(_DayMeal day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: day.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(day.icon, color: day.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day.day,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  day.meal,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            day.time,
            style: GoogleFonts.dmSans(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  List<_DayMeal> _days() {
    return const [
      _DayMeal('Monday', 'Lemon Herb Salmon Bowl', '7:00 PM', Icons.set_meal_rounded, AppTheme.accent),
      _DayMeal('Tuesday', 'Roasted Pepper Pasta', '6:30 PM', Icons.ramen_dining_rounded, AppTheme.spice),
      _DayMeal('Wednesday', 'Miso Chicken Wraps', '7:15 PM', Icons.restaurant_rounded, AppTheme.primary),
      _DayMeal('Thursday', 'Thai Basil Stir Fry', '6:45 PM', Icons.outdoor_grill_rounded, AppTheme.olive),
      _DayMeal('Friday', 'Wood-Fire Pizza Night', '8:00 PM', Icons.local_pizza_rounded, AppTheme.secondary),
    ];
  }
}

class _DayMeal {
  final String day;
  final String meal;
  final String time;
  final IconData icon;
  final Color color;

  const _DayMeal(this.day, this.meal, this.time, this.icon, this.color);
}
