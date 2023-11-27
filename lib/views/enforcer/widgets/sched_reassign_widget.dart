import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ScheduleReassignWidget extends StatelessWidget {
  const ScheduleReassignWidget({
    super.key,
    required this.ref,
    required this.trafficPostSearchController,
    required this.enforcerSearchController,
    required this.constraints,
  });

  final WidgetRef ref;
  final TextEditingController trafficPostSearchController;
  final TextEditingController enforcerSearchController;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Assign Traffic Post',
                      style: const UTextStyle().textlgfontmedium.copyWith(
                            color: UColors.gray500,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Visibility(
                      visible: ref.watch(selectedShiftProvider) != 'night',
                      child: TextField(
                        controller: trafficPostSearchController,
                        decoration: InputDecoration(
                          hintText: 'Search Traffic post',
                          prefixIcon: const Icon(Icons.search_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              USpace.space8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: USpace.space16,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Assign Enforcer',
                      style: const UTextStyle().textlgfontmedium.copyWith(
                            color: UColors.gray500,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: enforcerSearchController,
                      decoration: InputDecoration(
                        hintText: 'Search Enforcer',
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            USpace.space8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      USpace.space12,
                    ),
                    color: UColors.white,
                    border: Border.all(
                      color: UColors.gray200,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  child: const AssignableTrafficPostListView(),
                ),
              ),
              const SizedBox(
                width: USpace.space16,
              ),
              Expanded(
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      USpace.space12,
                    ),
                    color: UColors.white,
                    border: Border.all(
                      color: UColors.gray200,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  child: const AssignableEnforcerListView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
