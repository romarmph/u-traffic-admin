import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:universal_html/html.dart' as html;

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _passwordFormkey = GlobalKey<FormState>();

  bool _isLoading = false;

  final bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool isCancelVisible = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(() {
      setState(() {
        isCancelVisible = _currentPasswordController.text.isNotEmpty;
      });
    });
    _newPasswordController.addListener(() {
      setState(() {
        isCancelVisible = _newPasswordController.text.isNotEmpty;
      });
    });
    _confirmNewPasswordController.addListener(() {
      setState(() {
        isCancelVisible = _confirmNewPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.settings,
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(USpace.space16),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Container(
              padding: const EdgeInsets.all(USpace.space16),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    key: _passwordFormkey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                        border: Border.all(
                          color: UColors.gray200,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(USpace.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Account Security'),
                          const SizedBox(height: USpace.space12),
                          const Text('Change Password'),
                          const SizedBox(height: USpace.space12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  obscureText: _obscureCurrent,
                                  controller: _currentPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Current Password',
                                  ),
                                ),
                              ),
                              const SizedBox(width: USpace.space12),
                              Expanded(
                                child: TextFormField(
                                  obscureText: _obscureNew,
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                      labelText: 'New Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureNew = !_obscureNew;
                                            });
                                          },
                                          icon: Icon(_obscureNew
                                              ? Icons.visibility
                                              : Icons.visibility_off))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter new password';
                                    }

                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: USpace.space12),
                              Expanded(
                                child: TextFormField(
                                  obscureText: _obscureNew,
                                  controller: _confirmNewPasswordController,
                                  decoration: InputDecoration(
                                      labelText: 'Confirm New Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureNew = !_obscureNew;
                                            });
                                          },
                                          icon: Icon(_obscureNew
                                              ? Icons.visibility
                                              : Icons.visibility_off))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please confirm password';
                                    }

                                    if (value != _newPasswordController.text) {
                                      return 'Password does not match';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: USpace.space12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: _currentPasswordController
                                        .text.isNotEmpty ||
                                    _newPasswordController.text.isNotEmpty ||
                                    _confirmNewPasswordController
                                        .text.isNotEmpty,
                                child: SizedBox(
                                  width: 300,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: USpace.space24,
                                        vertical: USpace.space16,
                                      ),
                                    ),
                                    onPressed: () async {
                                      _currentPasswordController.clear();
                                      _newPasswordController.clear();
                                      _confirmNewPasswordController.clear();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: USpace.space24,
                                      vertical: USpace.space16,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (!_passwordFormkey.currentState!
                                        .validate()) {
                                      return;
                                    }

                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final auth = AuthService();
                                    final currentAdmin = ref.watch(
                                      currentAdminProvider,
                                    );

                                    try {
                                      await auth.testPassword(
                                        _currentPasswordController.text,
                                        currentAdmin.email,
                                      );
                                    } on CustomException catch (e) {
                                      if (e.code == 'incorrect-password') {
                                        QuickAlert.show(
                                          context: navigatorKey.currentContext!,
                                          type: QuickAlertType.error,
                                          title: 'Error',
                                          text: 'Incorrect password',
                                        );
                                      }

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      return;
                                    }

                                    await auth.changePassword(
                                      _newPasswordController.text,
                                    );

                                    setState(() {
                                      _isLoading = false;
                                    });

                                    QuickAlert.show(
                                      context: navigatorKey.currentContext!,
                                      type: QuickAlertType.success,
                                      title: 'Success',
                                      text: 'Password changed successfully',
                                    );

                                    _currentPasswordController.clear();
                                    _newPasswordController.clear();
                                    _confirmNewPasswordController.clear();
                                  },
                                  child: _isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USpace.space16),
                      border: Border.all(
                        color: UColors.gray200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(USpace.space16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UElevatedButton(
                          onPressed: () async {
                            await AuthService().logout();
                            html.window.location.reload();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
