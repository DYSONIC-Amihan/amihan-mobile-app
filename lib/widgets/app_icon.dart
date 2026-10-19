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


enum AppIconSize { sm, md, lg }

/// Icons come from Lucide (exported by shadcn_ui): LucideIcons.mail
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = AppIconSize.md, this.color, this.circled = false});

  final IconData icon;
  final AppIconSize size;
  final Color? color;
  final bool circled; // icon inside a muted circle

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final c = ShadTheme.of(context).colorScheme;
    final px = switch (size) { AppIconSize.sm => 16.0, AppIconSize.md => 24.0, AppIconSize.lg => 32.0 };
    final i = Icon(icon, size: px, color: color ?? c.foreground);
    if (!circled) return i;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: c.muted, shape: BoxShape.circle),
      child: i,
    );
  }
}
