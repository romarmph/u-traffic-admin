import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerCreatePage extends ConsumerStatefulWidget {
  const EnforcerCreatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnforcerCreatePageState();
}

class _EnforcerCreatePageState extends ConsumerState<EnforcerCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formProvider = ref.watch(enforcerFormProvider);
    return PageContainer(
      route: Routes.enforcersCreate,
      appBar: AppBar(
        title: const Text("Create Enforcer"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding: const EdgeInsets.all(USpace.space16),
                decoration: BoxDecoration(
                  color: UColors.white,
                  borderRadius: BorderRadius.circular(USpace.space16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enforcer Information',
                      style: TextStyle(
                        color: UColors.gray400,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: USpace.space16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 172,
                              height: 172,
                              padding: const EdgeInsets.all(USpace.space4),
                              decoration: BoxDecoration(
                                color: UColors.gray100,
                                borderRadius:
                                    BorderRadius.circular(USpace.space16),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 64,
                                  color: UColors.gray300,
                                ),
                              ),
                            ),
                            const SizedBox(height: USpace.space16),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(USpace.space16),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.add_a_photo_rounded),
                              label: const Text('Upload Photo'),
                            ),
                          ],
                        ),
                        const SizedBox(width: USpace.space16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _firstNameController,
                                      label: 'First Name',
                                      hintText: 'Ex. Juan',
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _middleNameController,
                                      label: 'Middle Name',
                                      hintText: 'Ex. Andres',
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _lastNameController,
                                      hintText: 'Ex. Dela Cruz',
                                      label: 'Last Name',
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 1,
                                    child: EnforcerFormField(
                                      controller: _suffixController,
                                      hintText: 'Ex. Jr.',
                                      label: 'Suffix',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: USpace.space16),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _emailController,
                                      hintText: 'Ex. example@mail.com',
                                      label: 'Email',
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _employeeNoController,
                                      hintText: 'Ex. 1000',
                                      label: 'Employee No.',
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 3,
                                    child: SizedBox.shrink(),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox.shrink(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: USpace.space16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: USpace.space16),
                    const Text(
                      'Enforcer Schedule',
                      style: TextStyle(
                        color: UColors.gray400,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: USpace.space16),
                    Expanded(
                      child: Container(
                        width: constraints.maxWidth,
                        child: ref.watch(getUnassignedEnforcerSchedStream).when(
                              data: (data) {
                                return SfDataGrid(
                                  selectionMode: SelectionMode.single,
                                  columnWidthMode: ColumnWidthMode.fill,
                                  source: UnassignedEnforcerSchedDataGridSource(
                                    data,
                                  ),
                                  columns: unassignedGridColumns,
                                );
                              },
                              error: (error, stackTrace) {
                                return const Center(
                                  child: Text(
                                    'Error fetching enforcer schedules',
                                    style: TextStyle(
                                      color: UColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
