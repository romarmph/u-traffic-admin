import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final updateOffenseProvider = StateProvider<List<ViolationOffense>>((ref) {
  return [];
});

class UpdateViolationForm extends ConsumerStatefulWidget {
  const UpdateViolationForm({
    super.key,
    this.violation,
  });

  final Violation? violation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdateViolationFormState();
}

class UpdateViolationFormState extends ConsumerState<UpdateViolationForm> {
  final _formKey = GlobalKey<FormState>();
  final _violationNameController = TextEditingController();
  bool _isDisabled = false;
  late List<ViolationOffense> offenses;

  @override
  void initState() {
    super.initState();
    _violationNameController.text = widget.violation!.name;
    _isDisabled = widget.violation!.isDisabled;
    offenses = widget.violation!.offense;
  }

  @override
  Widget build(BuildContext context) {
    offenses = ref.watch(updateOffenseProvider);
    offenses.sort((a, b) => a.level.compareTo(b.level));
    return PageContainer(
      route: Routes.systemViolations,
      appBar: AppBar(
        title: const Text("Update Violation"),
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
                            controller: _violationNameController,
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
                            value: _isDisabled,
                            onChanged: (value) {
                              setState(() {
                                _isDisabled = value;
                              });
                            },
                            title: const Text('Set as Disabled'),
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
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  contentPadding: EdgeInsets.all(16),
                                  surfaceTintColor: UColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(USpace.space12),
                                    ),
                                  ),
                                  title: Text('Add Offense'),
                                  content: OffenseCreateForm(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: USpace.space16,
                    ),
                    offenses.isEmpty
                        ? Container(
                            padding: const EdgeInsets.all(65),
                            decoration: BoxDecoration(
                                color: UColors.gray50,
                                borderRadius: BorderRadius.circular(
                                  USpace.space8,
                                ),
                                border: Border.all(
                                  color: UColors.gray200,
                                )),
                            child: Center(
                              child: Text(
                                'No Offenses Added',
                                style: const UTextStyle().textlgfontmedium,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: offenses.length,
                              itemBuilder: (context, index) {
                                final offense = offenses[index];
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
                                    trailing: SizedBox(
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    surfaceTintColor:
                                                        UColors.white,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            USpace.space12),
                                                      ),
                                                    ),
                                                    title: const Text(
                                                        'Add Offense'),
                                                    content: OffenseCreateForm(
                                                      offense: offense,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              ref
                                                  .read(
                                                    updateOffenseProvider
                                                        .notifier,
                                                  )
                                                  .state = [
                                                ...offenses
                                                    .where((element) =>
                                                        element.level !=
                                                        offense.level)
                                                    .toList(),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (offenses.isEmpty) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'No Offenses Added',
                                  text: 'Please add at least one offense',
                                );
                                return;
                              }

                              final currentAdmin =
                                  ref.read(currentAdminProvider);
                              final violation = widget.violation!.copyWith(
                                name: _violationNameController.text,
                                isDisabled: _isDisabled,
                                offense: offenses,
                                editedBy: currentAdmin.id,
                                dateEdited: Timestamp.now(),
                              );

                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.loading,
                                title: 'Updating Violation',
                                text: 'Please wait...',
                              );

                              await ViolationDatabase.instance
                                  .updateViolation(violation);

                              Navigator.of(navigatorKey.currentContext!).pop();

                              await QuickAlert.show(
                                context: navigatorKey.currentContext!,
                                type: QuickAlertType.success,
                                title: 'Violation Update',
                                text: 'The violation has been update',
                              );

                              Navigator.pop(navigatorKey.currentContext!);
                            }
                          },
                          child: const Text('Save Changes'),
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

class OffenseCreateForm extends ConsumerStatefulWidget {
  const OffenseCreateForm({
    super.key,
    this.offense,
  });

  final ViolationOffense? offense;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OffenseCreateFormState();
}

class _OffenseCreateFormState extends ConsumerState<OffenseCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _fineController = TextEditingController();
  final _penaltyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.offense != null) {
      _fineController.text = widget.offense!.fine.toString();
      _penaltyController.text = widget.offense!.penalty;
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentLevel = ref.watch(updateOffenseProvider).length + 1;
    if (widget.offense != null) {
      currentLevel = widget.offense!.level;
    }
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _fineController,
              decoration: const InputDecoration(
                labelText: 'Fine',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a fine amount';
                }

                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            TextFormField(
              controller: _penaltyController,
              decoration: const InputDecoration(
                labelText: 'Penalty',
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            TextFormField(
              initialValue: currentLevel.toString(),
              readOnly: true,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Level',
              ),
              keyboardType: TextInputType.number,
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
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final old = ref.watch(updateOffenseProvider);
                    if (_formKey.currentState!.validate()) {
                      if (widget.offense != null) {
                        ViolationOffense offense = ViolationOffense(
                          level: currentLevel,
                          fine: int.parse(_fineController.text),
                          penalty: _penaltyController.text,
                        );
                        old.removeWhere(
                            (element) => element.level == currentLevel);
                        ref.read(updateOffenseProvider.notifier).state = [
                          ...old,
                          offense,
                        ];
                      } else {
                        ViolationOffense offense = ViolationOffense(
                          level: currentLevel,
                          fine: int.parse(_fineController.text),
                          penalty: _penaltyController.text,
                        );
                        ref.read(updateOffenseProvider.notifier).state = [
                          ...old,
                          offense,
                        ];
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.offense != null ? "Save" : 'Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
