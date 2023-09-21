import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final isSelected = [!isDarkMode, isDarkMode];

    void toggle() {
      ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
    }

    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (index) => toggle(),
      children: const [
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
    );
  }
}
