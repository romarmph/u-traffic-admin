import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/system/update_forms/violation_update_form.dart';

class ViolationDetailsPage extends ConsumerWidget {
  const ViolationDetailsPage({
    super.key,
    required this.violationId,
  });

  final String violationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.systemViolations,
      appBar: AppBar(
        title: const Text("Create Violation"),
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
              child: ref.watch(violationByIdProvider(violationId)).when(
                  data: (violation) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Violation Details',
                          style: const UTextStyle().textxlfontmedium,
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.25,
                              child: TextFormField(
                                readOnly: true,
                                enabled: false,
                                initialValue: violation.name,
                                decoration: const InputDecoration(
                                  labelText: "Violation Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a violation name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.25,
                              child: SwitchListTile(
                                value: violation.isDisabled,
                                onChanged: null,
                                title: const Text('Disabled'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: USpace.space8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Violation Offense',
                              style: const UTextStyle().textxlfontmedium,
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: violation.offense.length,
                            itemBuilder: (context, index) {
                              final offense = violation.offense[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: UColors.green500,
                                    child: Text(
                                      offense.level.toString(),
                                      style:
                                          const UTextStyle().textxlfontmedium,
                                    ),
                                  ),
                                  title: Text(
                                    offense.fine.toString(),
                                  ),
                                  subtitle: Text(
                                    offense.penalty,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        AuthorWidget(
                          createdBy: violation.createdBy,
                          updatedBy: violation.editedBy,
                          createdAt: violation.dateCreated,
                          updatedAt: violation.dateEdited,
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back'),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                ref.read(updateOffenseProvider.notifier).state =
                                    violation.offense;
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        UpdateViolationForm(
                                      violation: violation,
                                    ),
                                  ),
                                );
                              },
                              label: const Text('Update Violation'),
                              icon: const Icon(Icons.edit_rounded),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text('Error fetching data'),
                    );
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
            );
          },
        ),
      ),
    );
  }
}
