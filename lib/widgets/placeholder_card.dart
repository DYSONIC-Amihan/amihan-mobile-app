import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Figma theme (Ami-Han). Carried inside this file so no ShadApp / main.dart change is needed.
final _theme = ShadThemeData(
  brightness: Brightness.light,
  radius: BorderRadius.circular(20),
  colorScheme: ShadColorScheme.fromName('slate').copyWith(
    background: const Color(0xFFF8FAFC),
    foreground: const Color(0xFF29586A),
    card: Colors.white,
    cardForeground: const Color(0xFF29586A),
    primary: const Color(0xFF29586A),
    primaryForeground: Colors.white,
    secondary: const Color(0xFFEBF8F8),
    secondaryForeground: const Color(0xFF29586A),
    muted: const Color(0xFFF1F5F9),
    mutedForeground: const Color(0xFF6C6B6B),
    accent: const Color(0xFFEBF8F8),
    accentForeground: const Color(0xFF29586A),
    border: const Color(0xFFE2E8F0),
    input: const Color(0xFF87C2C2),
    ring: const Color(0xFF87C2C2),
  ),
);


/// Card with grey placeholder blocks (image + 2 lines). Use while loading or as a layout stub.
/// Pass [title] / [subtitle] to swap the grey bars for real text.
class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({super.key, this.showImage = true, this.title, this.subtitle, this.onTap});

  final bool showImage;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;

  Widget _block(Color color, {double? width, double height = 12, double radius = 6}) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius)),
      );

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final grey = const Color(0xFFD9D9D9); // Figma placeholder grey

    final card = ShadCard(
      radius: BorderRadius.circular(10),
      border: ShadBorder.all(color: const Color(0x1A29586A), width: 1),
      child: Row(
        children: [
          if (showImage) ...[
            _block(grey, width: 64, height: 64, radius: 12),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title != null
                    ? Text(title!, style: theme.textTheme.p.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.foreground))
                    : _block(grey, width: 140, height: 16),
                const SizedBox(height: 8),
                subtitle != null
                    ? Text(subtitle!, style: theme.textTheme.p.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: theme.colorScheme.mutedForeground))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_block(grey), const SizedBox(height: 6), _block(grey, width: 90)],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return card;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: card);
  }
}
