import 'dart:async';

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UpdateEnforcerForm extends ConsumerStatefulWidget {
  const UpdateEnforcerForm({
    super.key,
    required this.enforcer,
  });

  final Enforcer enforcer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateEnforcerFormState();
}

class _UpdateEnforcerFormState extends ConsumerState<UpdateEnforcerForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _employeeNumberFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeNoController = TextEditingController();

  final _validator = EnforcerFormValidator();
  bool _emailExists = false;

  final _isChangesMadeProvider = StateProvider<bool>((ref) {
    final isProfilePhotoChanged = ref.watch(profilePhotoStateProvider) != null;
    final isStatusChanged = ref.watch(updateStatusProvider) != null;

    if (isProfilePhotoChanged || isStatusChanged) {
      return true;
    }

    return false;
  });

  @override
  void initState() {
    _firstNameController.text = widget.enforcer.firstName;
    _middleNameController.text = widget.enforcer.middleName;
    _lastNameController.text = widget.enforcer.lastName;
    _suffixController.text = widget.enforcer.suffix;
    _emailController.text = widget.enforcer.email;
    _employeeNoController.text = widget.enforcer.employeeNumber;
    _firstNameController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _firstNameController.text != widget.enforcer.firstName;
    });
    _middleNameController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _middleNameController.text != widget.enforcer.middleName;
    });
    _lastNameController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _lastNameController.text != widget.enforcer.lastName;
    });
    _suffixController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _suffixController.text != widget.enforcer.suffix;
    });
    _emailController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _emailController.text != widget.enforcer.email;
    });
    _employeeNoController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _employeeNoController.text != widget.enforcer.employeeNumber;
    });
    _passwordController.addListener(() {
      ref.watch(_isChangesMadeProvider.notifier).state =
          _passwordController.text.isNotEmpty &&
              _passwordController.text.length >= 6;
    });
    super.initState();
  }

  void _pickImageButtonTap() async {
    final image = await ImagePickerService.instance.pickImage();
    if (image != null) {
      ref.read(profilePhotoStateProvider.notifier).state = image;
    }
  }

  Future<bool> _isFormValid() async {
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

    return true;
  }

  void _onUpdateButtonTap() async {
    final isValid = await _isFormValid();

    if (!isValid) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Updating Enforcer',
      text: 'Please wait...',
    );

    final newPhotoUrl = await _uploadProfile();
    final newStatus = ref.watch(updateStatusProvider);
    final currentAdmin = ref.watch(currentAdminProvider);

    if (_emailController.text != widget.enforcer.email ||
        (_passwordController.text.isNotEmpty &&
            _passwordController.text.length >= 6)) {
      try {
        await EnforcerHTTPSerivice.instance.updateEnforcerAccount(
          widget.enforcer.id!,
          _emailController.text,
          _passwordController.text,
        );
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
        Navigator.of(navigatorKey.currentContext!).pop();
        if (e is int) {
          _showEnforcerCreateError(e);
        } else {
          _showEnforcerCreateError(-1);
        }
        return;
      }
    }

    final enforcer = Enforcer(
      id: widget.enforcer.id,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      suffix: _suffixController.text,
      email: _emailController.text != widget.enforcer.email
          ? _emailController.text
          : widget.enforcer.email,
      employeeNumber: _employeeNoController.text,
      status: newStatus ?? widget.enforcer.status,
      photoUrl: newPhotoUrl ?? widget.enforcer.photoUrl,
      createdBy: widget.enforcer.createdBy,
      createdAt: widget.enforcer.createdAt,
      updatedAt: Timestamp.now(),
      updatedBy: currentAdmin.id!,
    );

    try {
      await EnforcerDatabase.instance.updateEnforcer(enforcer);
    } catch (e) {
      _showEnforcerCreateError(-1);
      Navigator.of(navigatorKey.currentContext!).pop();
      return;
    }

    Navigator.of(navigatorKey.currentContext!).pop();
    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Enforcer Updated',
      text: 'The enforcer account has been updated',
    );
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  Future<String?> _uploadProfile() async {
    final profilePhoto = ref.watch(profilePhotoStateProvider);

    if (profilePhoto == null) {
      return null;
    }

    try {
      final url = await StorageService.instance.uploadImage(
        profilePhoto,
        widget.enforcer.id!,
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
        title: const Text('Update Enforcer'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcersEdit,
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
                            SizedBox(
                              width: 256,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        borderRadius: BorderRadius.circular(
                                            USpace.space16),
                                      ),
                                      child: profilePhoto != null
                                          ? Image.memory(profilePhoto.data!)
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  widget.enforcer.photoUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
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
                                  Visibility(
                                    visible: profilePhoto != null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: USpace.space12),
                                        TextButton.icon(
                                          style: FilledButton.styleFrom(
                                            padding: const EdgeInsets.all(
                                              USpace.space16,
                                            ),
                                            foregroundColor: UColors.red500,
                                          ),
                                          onPressed: () {
                                            ref
                                                .watch(profilePhotoStateProvider
                                                    .notifier)
                                                .state = null;
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: UColors.red500,
                                          ),
                                          label: const Text('Remove Photo'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                          flex: 2,
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
                                                    checkEmployeeNumberAvailable(
                                                  value!,
                                                ));

                                                if (!employeeNoExist &&
                                                    _employeeNoController
                                                            .text !=
                                                        widget.enforcer
                                                            .employeeNumber) {
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
                                                if (_emailExists &&
                                                    _emailController.text !=
                                                        widget.enforcer.email) {
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
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return null;
                                              }

                                              return value.length < 6
                                                  ? 'Password must be at least 6 characters'
                                                  : null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              const Text('Status'),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: USpace.space12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: UColors.gray100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    USpace.space8,
                                                  ),
                                                ),
                                                child: DropdownButton(
                                                  underline: const SizedBox(),
                                                  isExpanded: true,
                                                  value: _dropDownValue(),
                                                  onChanged: (value) {
                                                    if (value ==
                                                        widget
                                                            .enforcer.status) {
                                                      ref
                                                          .read(
                                                              updateStatusProvider
                                                                  .notifier)
                                                          .state = null;
                                                    } else {
                                                      ref
                                                              .read(
                                                                  updateStatusProvider
                                                                      .notifier)
                                                              .state =
                                                          value
                                                              as EmployeeStatus;
                                                    }
                                                  },
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value:
                                                          EmployeeStatus.active,
                                                      child: Text('Active'),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: EmployeeStatus
                                                          .onleave,
                                                      child: Text('On leave'),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: EmployeeStatus
                                                          .suspended,
                                                      child: Text('Suspended'),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: EmployeeStatus
                                                          .terminated,
                                                      child: Text('Terminated'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
                          onPressed: _onCancelButtonTap,
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
                          onPressed: !ref.watch(_isChangesMadeProvider)
                              ? null
                              : _onUpdateButtonTap,
                          label: const Text('Update Enforcer'),
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

  void _onCancelButtonTap() async {
    if (ref.watch(_isChangesMadeProvider)) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Unsaved Changes',
        text: 'Are you sure you want to leave this page?',
        showCancelBtn: true,
        onConfirmBtnTap: () {
          ref.watch(profilePhotoStateProvider.notifier).state = null;
          Navigator.of(navigatorKey.currentContext!).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                return const EnforcerPage();
              },
            ),
          );
        },
      );
      return;
    }

    ref.watch(profilePhotoStateProvider.notifier).state = null;
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return const EnforcerPage();
        },
      ),
    );
  }

  EmployeeStatus _dropDownValue() {
    final newStatus = ref.watch(updateStatusProvider);

    if (newStatus != null) {
      return newStatus;
    }

    return widget.enforcer.status;
  }

  void _showEnforcerCreateError(int statuscode) {
    if (statuscode >= 400 && statuscode < 500) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Update Error',
        text: 'Please check the enforcer information',
      );
      return;
    } else if (statuscode >= 500) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Update Error',
        text: 'Server error, please contact the system administrator',
      );
      return;
    } else if (statuscode == -1) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Update Error',
        text:
            'There was an error updating the enforcer account. Please contact the system administrator',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Enforcer Update Error',
        text: 'There was an error creating the enforcer account',
      );
      return;
    }
  }
}
