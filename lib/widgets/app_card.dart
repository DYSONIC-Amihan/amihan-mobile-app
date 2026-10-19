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


/// Figma card: radius 10, 1px border rgba(41,88,106,0.1), white by default.
/// Use [backgroundColor] for variants: weather #FFF9E6, current output #29586A.
/// Auth card on the login screen uses radius 25.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.title,
    this.description,
    this.footer,
    this.child,
    this.width,
    this.onTap,
    this.backgroundColor,
    this.radius = 10,
    this.padding,
  });

  final Widget? title;
  final Widget? description;
  final Widget? footer;
  final Widget? child;
  final double? width;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double radius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final card = ShadCard(
      width: width,
      title: title,
      description: description,
      footer: footer,
      padding: padding,
      backgroundColor: backgroundColor,
      radius: BorderRadius.circular(radius),
      border: ShadBorder.all(color: const Color(0x1A29586A), width: 1),
      child: child,
    );
    if (onTap == null) return card;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: card);
  }
}
