import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateTrafficPostForm extends ConsumerStatefulWidget {
  const CreateTrafficPostForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTrafficPostFormState();
}

class CreateTrafficPostFormState extends ConsumerState<CreateTrafficPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _trafficPostController = TextEditingController();
  final _postNumberController = TextEditingController();
  ULocation? _location;

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.systemTrafficPosts,
      appBar: AppBar(
        title: const Text("Create Traffic Post"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space12),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Traffic Post Details',
                      style: const UTextStyle().textxlfontmedium,
                    ),
                    const SizedBox(
                      height: USpace.space16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _postNumberController,
                            decoration: const InputDecoration(
                              labelText: "Traffic Post Number",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a traffic Post number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: USpace.space16,
                        ),
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            controller: _trafficPostController,
                            decoration: const InputDecoration(
                              labelText: "Traffic Post Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a traffic Post name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(0, 0),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {},
                          child: const Text('Create'),
                        ),
                      ],
                    ),
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


///
///
///
///
/// TODO: Add traffic post adding form
/// TODO: Fix enforcer to display traffic posts and schedule correctly
/// TODO: Implement ticket expiration in node js
///
///
///
///

