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


/// Figma: white pill input, teal border (theme `input` color), placeholder inside
/// (no label above). Wraps ShadInputFormField, so place it inside a ShadForm.
/// `id` is the key of this field in `formKey.currentState!.value`.
class InputBox extends StatefulWidget {
  const InputBox({
    super.key,
    required this.id,
    this.label,
    this.placeholder,
    this.description,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  final String id;
  final String? label; // optional: Figma has none
  final String? placeholder;
  final String? description;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? Function(String)? validator;
  final ValueChanged<String>? onChanged;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final brand = ShadTheme.of(context).colorScheme.foreground;
    return ShadInputFormField(
      id: widget.id,
      label: widget.label == null ? null : Text(widget.label!),
      placeholder: widget.placeholder == null ? null : Text(widget.placeholder!),
      description: widget.description == null ? null : Text(widget.description!),
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      obscureText: widget.isPassword && _obscure,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: brand),
      placeholderStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: brand.withValues(alpha: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: widget.icon == null ? null : Icon(widget.icon),
      trailing: widget.isPassword
          ? SizedBox.square(
              dimension: 24,
              child: OverflowBox(
                maxWidth: 28,
                maxHeight: 28,
                child: ShadIconButton.ghost(
                  iconSize: 20,
                  padding: const EdgeInsets.all(2),
                  icon: Icon(_obscure ? LucideIcons.eyeOff : LucideIcons.eye),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            )
          : null,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
