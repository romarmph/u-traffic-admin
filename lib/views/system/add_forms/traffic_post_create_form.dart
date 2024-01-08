import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateTrafficPostForm extends ConsumerStatefulWidget {
  const CreateTrafficPostForm({
    super.key,
    this.post,
  });

  final TrafficPost? post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTrafficPostFormState();
}

class CreateTrafficPostFormState extends ConsumerState<CreateTrafficPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _postNameController = TextEditingController();
  final _postLocationController = TextEditingController();
  final _postNumberController = TextEditingController();
  ULocation? _postLocation;

  // 15.975879, 120.567371

  late GoogleMapController mapController;
  Set<Marker> markers = {};

  void _createPost() async {
    if (_formKey.currentState!.validate()) {
      if (_postLocation == null) {
        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.error,
          title: "Error",
          text: "Please select post location",
        );
        return;
      }

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
        location: _postLocation!,
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

      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  void _updatePost() async {
    if (_formKey.currentState!.validate()) {
      final result = await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Update Post",
        text: "Are you sure you want to update this post?",
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
        title: "Updating Post",
        text: "Please wait...",
      );

      final currentAdmin = ref.read(currentAdminProvider);

      final post = widget.post!.copyWith(
        name: _postNameController.text,
        location: ULocation(
          address: _postLocationController.text,
          lat: markers.first.position.latitude,
          long: markers.first.position.longitude,
        ),
        number: int.parse(_postNumberController.text),
        updatedBy: currentAdmin.id!,
        updatedAt: Timestamp.now(),
      );

      try {
        await TrafficPostDatabase.instance.updatePost(post);
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
        text: "Post updated successfully",
      );
    }

    Navigator.of(navigatorKey.currentContext!).pop();
  }

  @override
  void initState() {
    super.initState();
    // final currentPosts = ref.watch(trafficPostProvider);

    // for (final post in currentPosts) {
    //   markers.add(
    //     Marker(
    //       markerId: MarkerId(post.id!),
    //       position: LatLng(post.location.lat, post.location.long),
    //       infoWindow: InfoWindow(
    //         title: post.name,
    //         snippet: post.location.address,
    //       ),
    //     ),
    //   );
    // }

    if (widget.post != null) {
      _postNameController.text = widget.post!.name;
      _postLocationController.text = widget.post!.location.address;
      _postNumberController.text = widget.post!.number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.systemTrafficPosts,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
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
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextFormField(
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
                                  .where((element) =>
                                      element.number == int.parse(value))
                                  .toList();

                              if (post.isNotEmpty && widget.post == null) {
                                if (_postNumberController.text ==
                                    widget.post!.number.toString()) {
                                  return null;
                                }

                                return "Post number already in use";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                    const Text("Select Post Location"),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(USpace.space8),
                        ),
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            setState(() {
                              mapController = controller;
                            });
                          },
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(15.975879, 120.567371),
                            zoom: 16,
                          ),
                          markers: markers,
                          onTap: (argument) async {
                            setState(() {
                              markers.add(
                                Marker(
                                  markerId: const MarkerId('temp'),
                                  position: argument,
                                  infoWindow: InfoWindow(
                                    title: "Post Location",
                                    snippet: argument.toString(),
                                  ),
                                ),
                              );
                              _postLocation = ULocation(
                                address: _postLocationController.text,
                                lat: argument.latitude,
                                long: argument.longitude,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                          onPressed:
                              widget.post != null ? _updatePost : _createPost,
                          child: Text(widget.post != null ? "Update" : "Save"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
