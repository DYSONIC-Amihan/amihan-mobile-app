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


/// Font sizes + hierarchy taken from the Figma prototype (Inter).
///
///   display  32 SemiBold  big numbers (0.10 kW, 72%, 28)
///   h1       25 SemiBold  screen / card title ("Login", "Sign Up")
///   h2       18 SemiBold  card title ("Sunny Day")
///   h3       14 SemiBold  section label ("TODAY'S WEATHER")
///   body     13 Medium    inputs, buttons, normal text
///   small    12 Medium    secondary text, links
///   caption  11 Medium    nav labels, tiny text
///   muted    12 Medium    grey helper text
enum _Kind { display, h1, h2, h3, body, small, caption, muted }

class AppText extends StatelessWidget {
  const AppText.display(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.display;
  const AppText.h1(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.h1;
  const AppText.h2(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.h2;
  const AppText.h3(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.h3;
  const AppText.body(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.body;
  const AppText.small(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.small;
  const AppText.caption(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.caption;
  const AppText.muted(this.data, {super.key, this.color, this.align, this.maxLines}) : _kind = _Kind.muted;

  final String data;
  final _Kind _kind;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final base = theme.textTheme.p.copyWith(height: 1.3);
    final brand = theme.colorScheme.foreground;
    final grey = theme.colorScheme.mutedForeground;

    final style = switch (_kind) {
      _Kind.display => base.copyWith(fontSize: 32, fontWeight: FontWeight.w600, color: brand),
      _Kind.h1 => base.copyWith(fontSize: 25, fontWeight: FontWeight.w600, color: brand),
      _Kind.h2 => base.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: brand),
      _Kind.h3 => base.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: grey),
      _Kind.body => base.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: brand),
      _Kind.small => base.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: brand),
      _Kind.caption => base.copyWith(fontSize: 11, fontWeight: FontWeight.w500, color: grey),
      _Kind.muted => base.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: grey),
    };
    return Text(
      data,
      style: color == null ? style : style.copyWith(color: color),
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
    );
  }
}
