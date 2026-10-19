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


/// Wrap InputBox fields in this. Validate with:
///   final key = GlobalKey<ShadFormState>();
///   AppForm(formKey: key, child: ...);
///   if (key.currentState!.saveAndValidate()) { key.currentState!.value['email']; }
class AppForm extends StatelessWidget {
  const AppForm({super.key, this.formKey, required this.child});

  final GlobalKey<ShadFormState>? formKey;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ShadTheme(data: _theme, child: ShadForm(key: formKey, child: child));
}
