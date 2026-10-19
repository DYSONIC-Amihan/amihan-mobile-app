import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, link, destructive }

/// Figma button: teal pill (#87C2C2), white text, height 46, radius 20.
/// `outline` = white button with grey border (e.g. "Continue with Google").
/// Self-contained: carries its own theme, so no ShadApp / main.dart changes needed.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.leading,
    this.isLoading = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;

  /// Custom leading widget (e.g. Google logo). Overrides [icon].
  final Widget? leading;
  final bool isLoading;
  final bool fullWidth;

  static const _brand = Color(0xFF29586A);
  static const _teal = Color(0xFF87C2C2);
  static const _tealHover = Color(0xFF6FB3B3);
  static const double _height = 46;

  static final _theme = ShadThemeData(
    brightness: Brightness.light,
    radius: BorderRadius.circular(20),
    colorScheme: ShadColorScheme.fromName('slate').copyWith(
      foreground: _brand,
      primary: _brand,
      primaryForeground: Colors.white,
      secondary: const Color(0xFFEBF8F8),
      secondaryForeground: _brand,
      border: const Color(0xFFE2E8F0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ShadTheme(data: _theme, child: Builder(builder: _build));
  }

  Widget _build(BuildContext context) {
    final scheme = ShadTheme.of(context).colorScheme;
    final spinnerColor = variant == AppButtonVariant.primary
        ? Colors.white
        : variant == AppButtonVariant.destructive
            ? scheme.destructiveForeground
            : scheme.foreground;

    final Widget? lead = isLoading
        ? SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: spinnerColor),
          )
        : (leading ?? (icon == null ? null : Icon(icon, size: 16)));

    final tap = isLoading ? () {} : onPressed; // keep enabled look while loading
    final width = fullWidth ? double.infinity : null;
    final child = Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600));

    switch (variant) {
      case AppButtonVariant.primary:
        return ShadButton(
          width: width,
          height: _height,
          backgroundColor: _teal,
          hoverBackgroundColor: _tealHover,
          foregroundColor: Colors.white,
          leading: lead,
          onPressed: tap,
          child: child,
        );
      case AppButtonVariant.secondary:
        return ShadButton.secondary(width: width, height: _height, leading: lead, onPressed: tap, child: child);
      case AppButtonVariant.outline:
        return ShadButton.outline(width: width, height: _height, leading: lead, onPressed: tap, child: child);
      case AppButtonVariant.ghost:
        return ShadButton.ghost(width: width, height: _height, leading: lead, onPressed: tap, child: child);
      case AppButtonVariant.link:
        return ShadButton.link(width: width, leading: lead, onPressed: tap, child: child);
      case AppButtonVariant.destructive:
        return ShadButton.destructive(width: width, height: _height, leading: lead, onPressed: tap, child: child);
    }
  }
}
