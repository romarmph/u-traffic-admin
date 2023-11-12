import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemMenu extends StatelessWidget {
  const SystemMenu({
    super.key,
    required this.screen,
  });

  final String screen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(USpace.space16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SystemMenuButton(
                  icon: Icons.rule_rounded,
                  title: "Violations",
                  onTap: () {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const SystemPage(),
                      ),
                    );
                  },
                  isActive: screen == 'violations',
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SystemMenuButton(
                  icon: Icons.car_repair_rounded,
                  title: "Vehicle Types",
                  onTap: () {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            const SystemVehicleTypePage(),
                      ),
                    );
                  },
                  isActive: screen == 'vehicle_types',
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SystemMenuButton(
                  icon: Icons.traffic_rounded,
                  title: "Traffic Posts",
                  onTap: () {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            const SystemTrafficPostPage(),
                      ),
                    );
                  },
                  isActive: screen == 'traffic_posts',
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SystemMenuButton(
                  icon: Icons.calendar_month_rounded,
                  title: "Enforcer Schedule",
                  onTap: () {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            const SystemEncforcerSchedulePage(),
                      ),
                    );
                  },
                  isActive: screen == 'enforcer_schedule',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
