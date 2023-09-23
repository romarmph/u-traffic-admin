import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final isSelected = [!isDarkMode, isDarkMode];
    final deviceWidth = MediaQuery.of(context).size.width;
    final isCompact = deviceWidth <= 600;

    void toggle() {
      ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
    }

    print(isCompact);

    if (isCompact) {
      return IconButton(
        onPressed: () => toggle(),
        icon: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: isDarkMode ? UColors.gray300 : UColors.blue800,
        ),
      );
    } else {
      return ToggleButtons(
        borderRadius: BorderRadius.circular(12),
        isSelected: isSelected,
        onPressed: (index) => toggle(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.light_mode,
                  color: isDarkMode ? UColors.gray300 : UColors.blue800,
                ),
                const SizedBox(width: 4),
                Text(
                  'Light',
                  style: TextStyle(
                    color: isDarkMode ? UColors.gray300 : UColors.blue800,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 4),
                Text('Dark'),
              ],
            ),
          ),
        ],
      );
    }
  }
}
