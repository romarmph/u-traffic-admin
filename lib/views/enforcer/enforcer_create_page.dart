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
  bool _isPasswordVisible = false;
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _employeeNoController = TextEditingController();

  final _validator = EnforcerFormValidator();

  bool _isFormValid() {
    final form = ref.watch(enforcerFormProvider);
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (form.profileImage == null) {
      _showProfilePhotoMissingError();
      return false;
    }

    if (form.scheduleId.isEmpty) {
      _showScheduleMissingError();
      return false;
    }

    return true;
  }

  void _pickImageButtonTap() async {
    final image = await ImagePickerService.instance.pickImage();
    if (image != null) {
      ref.watch(enforcerFormProvider).setProfileImage(image.data!);
    }
  }

  void _onSaveButtonTap() async {
    if (!_isFormValid()) {
      return;
    }

    final form = ref.watch(enforcerFormProvider);

    late String uid;

    try {
      uid = await EnforcerHTTPSerivice.instance.createEnforcerAccount(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      _showEnforcerCreateError(e as int);
      return;
    }

    final currentAdmin = ref.read(currentAdminProvider);

    final url = await _uploadProfile(uid);

    final enforcer = Enforcer(
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      suffix: _suffixController.text,
      email: _emailController.text,
      status: EmployeeStatus.active,
      photoUrl: url!,
      employeeNumber: _employeeNoController.text,
      createdBy: currentAdmin.id!,
      updatedBy: currentAdmin.id!,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    try {
      await EnforcerDatabase.instance.addEnforcer(
        enforcer,
        uid,
      );
      await EnforcerScheduleDatabse.instance.setEnforcerToSchedule(
          enforcerId: uid,
          scheduleId: form.scheduleId,
          adminId: currentAdmin.id!,
          enforcerName:
              '${enforcer.firstName} ${enforcer.middleName.initial} ${enforcer.lastName}');
    } catch (e) {
      _showEnforcerCreateError(-1);
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Enforcer Created',
      text: 'Enforcer account has been created',
    );
  }

  Future<String?> _uploadProfile(String uid) async {
    final form = ref.watch(enforcerFormProvider);

    try {
      final url = await StorageService.instance.uploadImage(
        MediaInfo(
          data: form.profileImage,
          fileName: 'profile',
        ),
        uid,
      );

      return url;
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Profile Upload Error',
        text: 'There was an error uploading the profile photo',
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              onPressed: _pickImageButtonTap,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _firstNameController,
                                      label: 'First Name',
                                      hintText: 'Ex. Juan',
                                      validator: _validator.validateFirstName,
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
                                      validator: _validator.validateLastName,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _emailController,
                                      hintText: 'Ex. example@mail.com',
                                      label: 'Email',
                                      validator: _validator.validateEmail,
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _employeeNoController,
                                      hintText: 'Ex. 1000',
                                      label: 'Employee No.',
                                      validator: _validator.validateEmployeeNo,
                                    ),
                                  ),
                                  const SizedBox(width: USpace.space12),
                                  Expanded(
                                    flex: 3,
                                    child: EnforcerFormField(
                                      controller: _passwordController,
                                      hintText: '',
                                      label: 'Password',
                                      obscureText: !_isPasswordVisible,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _isPasswordVisible
                                              ? UColors.blue400
                                              : UColors.gray400,
                                        ),
                                      ),
                                      validator: _validator.validatePassword,
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox.shrink(),
                                  ),
                                ],
                              ),
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
                        clipBehavior: Clip.antiAlias,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(USpace.space16),
                          border: Border.all(
                            color: UColors.gray200,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                        child: ref.watch(getUnassignedEnforcerSchedStream).when(
                              data: (data) {
                                return SfDataGrid(
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.vertical,
                                  gridLinesVisibility:
                                      GridLinesVisibility.horizontal,
                                  selectionMode: SelectionMode.single,
                                  columnWidthMode: ColumnWidthMode.fill,
                                  allowSorting: true,
                                  allowFiltering: true,
                                  source: UnassignedEnforcerSchedDataGridSource(
                                    data,
                                  ),
                                  columns: unassignedGridColumns,
                                  footer: Visibility(
                                    visible: data.isEmpty,
                                    child: const Center(
                                      child: Text(
                                        'No schedules found',
                                        style: TextStyle(
                                          color: UColors.gray400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
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
                    const SizedBox(height: USpace.space16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: USpace.space32,
                              vertical: USpace.space24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                USpace.space8,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: USpace.space16),
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: USpace.space32,
                              vertical: USpace.space24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                USpace.space8,
                              ),
                            ),
                          ),
                          onPressed: _onSaveButtonTap,
                          label: const Text('Save'),
                          icon: const Icon(Icons.save_rounded),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProfilePhotoMissingError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Profile Photo Missing',
      text: 'Please upload a profile photo',
    );
  }

  void _showScheduleMissingError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Schedule Missing',
      text: 'Please select a schedule',
    );
  }

  void _showEnforcerCreateError(int statuscode) {
    if (statuscode == -1) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Create Error',
        text:
            'There was an error creating the enforcer account. Please contact the system administrator',
      );
    }

    if (statuscode >= 400 && statuscode < 500) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Create Error',
        text: 'Please check the enforcer information',
      );
    } else if (statuscode >= 500) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Create Error',
        text: 'Server error, please contact the system administrator',
      );
    }
  }
}
