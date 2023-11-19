import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemMenu extends ConsumerStatefulWidget {
  const SystemMenu({
    super.key,
    required this.route,
  });

  final String route;

  @override
  ConsumerState<SystemMenu> createState() => _SystemMenuState();
}

class _SystemMenuState extends ConsumerState<SystemMenu> {
  final _searchControler = TextEditingController();

  bool isSearchClearIconVisible = false;

  @override
  void initState() {
    _searchControler.addListener(() {
      setState(() {
        isSearchClearIconVisible = _searchControler.text.isNotEmpty;
      });
    });
    super.initState();
  }

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
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _searchControler,
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                    hintText: "Quick Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(USpace.space8),
                    ),
                    suffixIcon: Visibility(
                      visible: _searchControler.text.isNotEmpty,
                      child: IconButton(
                        onPressed: _onClear,
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Visibility(
                visible: widget.route != Routes.systemFiles,
                child: UElevatedButton(
                  onPressed: () {},
                  child: Text(_buttonTitle(widget.route)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClear() {
    _searchControler.clear();
    ref.read(violationSearchQueryProvider.notifier).state = "";
    ref.read(vehicleTypeSearchQueryProvider.notifier).state = "";
    ref.read(postSearchQueryProvider.notifier).state = "";
    ref.read(fileSearchQueryProvider.notifier).state = "";
  }

  void _onChanged(value) {
    if (widget.route == Routes.systemViolations) {
      ref
          .read(
            violationSearchQueryProvider.notifier,
          )
          .state = value;
    } else if (widget.route == Routes.systemVehicleTypes) {
      ref
          .read(
            vehicleTypeSearchQueryProvider.notifier,
          )
          .state = value;
    } else if (widget.route == Routes.systemTrafficPosts) {
      ref
          .read(
            postSearchQueryProvider.notifier,
          )
          .state = value;
    } else {
      ref
          .read(
            fileSearchQueryProvider.notifier,
          )
          .state = value;
    }
  }

  String _buttonTitle(String route) {
    switch (route) {
      case Routes.systemViolations:
        return "Add Violation";
      case Routes.systemTrafficPosts:
        return "Add Posts";
      case Routes.systemVehicleTypes:
        return "Add Vehicle Types";
      default:
        return "Add Violations";
    }
  }
}
