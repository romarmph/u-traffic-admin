import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/system/add_forms/traffic_post_create_form.dart';
import 'package:u_traffic_admin/views/system/add_forms/vehicle_type_create_form.dart';
import 'package:u_traffic_admin/views/system/add_forms/violation_add_form.dart';

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
                  onPressed: () {
                    if (widget.route == Routes.systemViolations) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const CreateViolationForm(),
                        ),
                      );
                    }

                    if (widget.route == Routes.systemTrafficPosts) {
                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //     pageBuilder: (_, __, ___) =>
                      //         const CreateTrafficPostForm(),
                      //   ),
                      // );
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: CreateVehicleTypeFormDialog(),
                            );
                          });
                    }

                    if (widget.route == Routes.systemVehicleTypes) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: CreateVehicleTypeForm(),
                          );
                        },
                      );
                    }
                  },
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

class CreateVehicleTypeFormDialog extends ConsumerStatefulWidget {
  const CreateVehicleTypeFormDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateVehicleTypeFormDialogState();
}

class CreateVehicleTypeFormDialogState
    extends ConsumerState<CreateVehicleTypeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _postNameController = TextEditingController();
  final _postLocationController = TextEditingController();
  final _postNumberController = TextEditingController();

  void _createPost() async {
    if (_formKey.currentState!.validate()) {
      final result = await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Create Post",
        text: "Are you sure you want to create this post?",
        onConfirmBtnTap: () {
          Navigator.of(context).pop(true);
        },
      );

      if (result != true) {
        return;
      }

      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.loading,
        title: "Creating Post",
        text: "Please wait...",
      );

      final currentAdmin = ref.read(currentAdminProvider);
      final post = TrafficPost(
        name: _postNameController.text,
        location: ULocation(
          address: _postLocationController.text,
          lat: 0,
          long: 0,
        ),
        number: int.parse(_postNumberController.text),
        createdBy: currentAdmin.id!,
        createdAt: Timestamp.now(),
      );

      try {
        await TrafficPostDatabase.instance.addPost(post);
        Navigator.of(navigatorKey.currentContext!).pop();
      } catch (e) {
        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.error,
          title: "Error",
          text: e.toString(),
        );
        Navigator.of(navigatorKey.currentContext!).pop();
        return;
      }

      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.success,
        title: "Success",
        text: "Post created successfully",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space16),
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create Traffic Post'),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _postNameController,
              decoration: const InputDecoration(
                labelText: "Post Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter post name";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _postLocationController,
              decoration: const InputDecoration(
                labelText: "Post Location",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter post location";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _postNumberController,
              decoration: const InputDecoration(
                labelText: "Post Number",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter post number";
                }

                if (int.tryParse(value) == null) {
                  return "Please enter a valid number";
                }

                final posts = ref.read(trafficPostProvider);
                final post = posts
                    .where((element) => element.number == int.parse(value))
                    .toList();

                if (post.isNotEmpty) {
                  return "Post number already in use";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  onPressed: _createPost,
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
