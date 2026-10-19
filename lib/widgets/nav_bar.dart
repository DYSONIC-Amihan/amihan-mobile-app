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


class NavItem {
  const NavItem({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

/// Figma bottom nav: white bar, top border #E2E8F0, height 76.
/// Active tab = teal pill (#0D9488) with white icon and bold teal label;
/// inactive = slate (#64748B) icon + label.
/// Use as `Scaffold(bottomNavigationBar: NavBar(...))`.
class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.items, required this.currentIndex, required this.onTap});

  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _teal = Color(0xFF0D9488);
  static const _slate = Color(0xFF64748B);
  static const _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) => ShadTheme(data: _theme, child: Builder(builder: _build));

  Widget _build(BuildContext context) {
    final font = ShadTheme.of(context).textTheme.p;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(i),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 64,
                          height: 35,
                          decoration: BoxDecoration(
                            color: i == currentIndex ? _teal : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(items[i].icon, size: 24, color: i == currentIndex ? Colors.white : _slate),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[i].label,
                          style: font.copyWith(
                            fontSize: 11,
                            fontWeight: i == currentIndex ? FontWeight.w700 : FontWeight.w500,
                            color: i == currentIndex ? _teal : _slate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
