import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateEnforcerForm extends ConsumerStatefulWidget {
  const CreateEnforcerForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateEnforcerFormState();
}

class _CreateEnforcerFormState extends ConsumerState<CreateEnforcerForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _employeeNumberFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _employeeNoController = TextEditingController();
  bool _emailExists = false;

  final _validator = EnforcerFormValidator();

  Future<bool> _isFormValid() async {
    final profilePhoto = ref.watch(profilePhotoStateProvider);
    if (!_formKey.currentState!.validate()) {
      !_emailFormKey.currentState!.validate();
      !_employeeNumberFormKey.currentState!.validate();
      return false;
    }

    if (!_emailFormKey.currentState!.validate()) {
      return false;
    }

    if (!_employeeNumberFormKey.currentState!.validate()) {
      return false;
    }

    final isEmailAvailable = await AuthService().isEmailAvailable(
      _emailController.text,
    );
    setState(() {
      _emailExists = !isEmailAvailable;
    });

    if (profilePhoto == null) {
      _showProfilePhotoMissingError();
      return false;
    }

    return true;
  }

  void _pickImageButtonTap() async {
    final image = await ImagePickerService.instance.pickImage();
    if (image != null) {
      ref.read(profilePhotoStateProvider.notifier).state = image;
    }
  }

  void _onSaveButtonTap() async {
    final isFormValid = await _isFormValid();
    if (!isFormValid) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Creating Enforcer',
      text: 'Please wait...',
    );

    late String uid;

    try {
      final result = await EnforcerHTTPSerivice.instance.createEnforcerAccount(
        _emailController.text,
        _passwordController.text,
      );

      final data = jsonDecode(result);
      uid = data['uid'];
    } on TimeoutException {
      Navigator.of(navigatorKey.currentContext!).pop();
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Enforcer Create Error',
        text: 'Connection timeout, please try again',
      );
      return;
    } catch (e) {
      _showEnforcerCreateError(-1);
      return;
    }

    final currentAdmin = ref.watch(currentAdminProvider);

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
      createdAt: Timestamp.now(),
    );

    try {
      await EnforcerDatabase.instance.addEnforcer(
        enforcer,
        uid,
      );
    } catch (e) {
      _showEnforcerCreateError(-1);
      return;
    }

    Navigator.pop(navigatorKey.currentContext!);

    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Enforcer Created',
      text: 'Enforcer account has been created',
    );

    ref.read(profilePhotoStateProvider.notifier).state = null;
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return const EnforcerPage();
        },
      ),
    );
  }

  Future<String?> _uploadProfile(String uid) async {
    final profilePhoto = ref.watch(profilePhotoStateProvider);

    try {
      final url = await StorageService.instance.uploadImage(
        profilePhoto!,
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
    final profilePhoto = ref.watch(profilePhotoStateProvider);
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Enforcer'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcersCreate,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: constraints.maxHeight - 100 - 48,
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
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 256,
                                    height: 256,
                                    padding:
                                        const EdgeInsets.all(USpace.space4),
                                    decoration: BoxDecoration(
                                      color: UColors.gray100,
                                      borderRadius:
                                          BorderRadius.circular(USpace.space16),
                                    ),
                                    child: profilePhoto != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.memory(
                                              profilePhoto.data!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const Center(
                                            child: Icon(
                                              Icons.add_a_photo_rounded,
                                              size: 64,
                                              color: UColors.gray300,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: USpace.space16),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    padding:
                                        const EdgeInsets.all(USpace.space16),
                                  ),
                                  onPressed: _pickImageButtonTap,
                                  icon: const Icon(Icons.add_a_photo_rounded),
                                  label: const Text('Upload Photo'),
                                ),
                              ],
                            ),
                            const SizedBox(width: USpace.space16),
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: EnforcerFormField(
                                            controller: _firstNameController,
                                            label: 'First Name',
                                            hintText: 'Ex. Juan',
                                            validator:
                                                _validator.validateFirstName,
                                          ),
                                        ),
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
                                            validator:
                                                _validator.validateLastName,
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
                                    const SizedBox(height: USpace.space12),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Form(
                                            key: _employeeNumberFormKey,
                                            child: EnforcerFormField(
                                              controller: _employeeNoController,
                                              hintText: '',
                                              label: 'Employee No.',
                                              onChanged: (value) async {
                                                _employeeNumberFormKey
                                                    .currentState!
                                                    .validate();
                                              },
                                              validator: (value) {
                                                final employeeNoExist = ref.watch(
                                                    findEnforcerWithEmployeeNo(
                                                  value!,
                                                ));

                                                if (!employeeNoExist) {
                                                  return 'Employee No. already exist';
                                                }

                                                return _validator
                                                    .validateEmployeeNo(value);
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 3,
                                          child: Form(
                                            key: _emailFormKey,
                                            child: EnforcerFormField(
                                              controller: _emailController,
                                              hintText: 'Ex. example@mail.com',
                                              label: 'Email',
                                              suffixIcon: const Tooltip(
                                                message:
                                                    'Will be used to login',
                                                child: Icon(
                                                  Icons.info_rounded,
                                                  color: UColors.gray400,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (_emailExists) {
                                                  return 'Email already in use';
                                                }
                                                return _validator
                                                    .validateEmail(value);
                                              },
                                            ),
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
                                            validator:
                                                _validator.validatePassword,
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: USpace.space16,
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(USpace.space16),
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USpace.space16),
                    ),
                    child: Row(
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
                          onPressed: () {
                            ref
                                .watch(profilePhotoStateProvider.notifier)
                                .state = null;
                            Navigator.of(navigatorKey.currentContext!)
                                .pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) {
                                  return const EnforcerPage();
                                },
                              ),
                            );
                          },
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
                          label: const Text('Create Enforcer'),
                          icon: const Icon(Icons.save_rounded),
                        ),
                      ],
                    ),
                  )
                ],
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
