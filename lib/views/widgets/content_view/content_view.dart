import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ContentView extends ConsumerWidget {
  const ContentView({
    super.key,
    this.appBar,
    required this.body,
  });

  final Widget body;
  final Widget? appBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final tileBgColor = isDarkMode ? UColors.gray800 : UColors.white;

    return Container(
      padding: const EdgeInsets.all(
        USpace.space16,
      ),
      child: Column(
        children: [
          appBar ?? const SizedBox.shrink(),
          SizedBox(
            height: appBar != null ? USpace.space16 : 0,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (
                BuildContext context,
                BoxConstraints viewportConstraints,
              ) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      height: viewportConstraints.constrainHeight(),
                      width: viewportConstraints.constrainWidth(),
                      decoration: BoxDecoration(
                        color: tileBgColor,
                        borderRadius: BorderRadius.circular(
                          USpace.space12,
                        ),
                      ),
                      child: body,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
