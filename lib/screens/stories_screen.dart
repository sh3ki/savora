import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = _stories();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: AppLogo(size: 34, showText: false),
            ),
            const SizedBox(height: 6),
            Text(
              'Chef Stories',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Global plates and creators that inspire your next cook.',
              style: GoogleFonts.dmSans(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => _miniStory(stories[index]),
              ),
            ),
            const SizedBox(height: 18),
            ...stories.map(_storyCard),
          ],
        ),
      ),
    );
  }

  Widget _miniStory(_Story story) {
    return Column(
      children: [
        Container(
          width: 66,
          height: 66,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.secondary]),
          ),
          child: ClipOval(
            child: Image.network(story.avatar, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          story.name.split(' ').first,
          style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _storyCard(_Story story) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              story.cover,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(story.avatar), radius: 14),
                    const SizedBox(width: 8),
                    Text(
                      story.name,
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  story.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 23,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  story.subtitle,
                  style: GoogleFonts.dmSans(color: AppTheme.textSecondary, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_Story> _stories() {
    return const [
      _Story(
        'Maya Chen',
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=500&q=80',
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
        'Street Food Night in Bangkok',
        'A fire-kissed tasting journey through night-market classics and hand-ground chili pastes.',
      ),
      _Story(
        'Diego Alvarez',
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=80',
        'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?auto=format&fit=crop&w=1200&q=80',
        'Brunch Atelier',
        'Build elevated weekend brunch plates with texture contrast, fresh herbs, and citrus oils.',
      ),
      _Story(
        'Nadia Noor',
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=500&q=80',
        'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=1200&q=80',
        'Dessert Lab: Caramel & Smoke',
        'How to layer deep caramel notes with controlled smoke for dramatic plated desserts.',
      ),
    ];
  }
}

class _Story {
  final String name;
  final String avatar;
  final String cover;
  final String title;
  final String subtitle;

  const _Story(this.name, this.avatar, this.cover, this.title, this.subtitle);
}
