import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateTrafficPostFormDialog extends ConsumerStatefulWidget {
  const CreateTrafficPostFormDialog({
    super.key,
    this.post,
  });

  final TrafficPost? post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTrafficPostFormDialogState();
}

class CreateTrafficPostFormDialogState
    extends ConsumerState<CreateTrafficPostFormDialog> {
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
          lat: 0,
          long: 0,
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
    if (widget.post != null) {
      _postNameController.text = widget.post!.name;
      _postLocationController.text = widget.post!.location.address;
      _postNumberController.text = widget.post!.number.toString();
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
                  onPressed: widget.post != null ? _updatePost : _createPost,
                  child: Text(widget.post != null ? "Update" : "Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
