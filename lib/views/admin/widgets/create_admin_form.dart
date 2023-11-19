import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateAdminForm extends ConsumerStatefulWidget {
  const CreateAdminForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAdminFormState();
}

class _CreateAdminFormState extends ConsumerState<CreateAdminForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _employeeNumberFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeNoController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final profilePhoto = ref.watch(profilePhotoStateProvider);
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Admin'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.adminStaffsCreate,
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
                          'Admin Information',
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
                                  onPressed: () {},
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: USpace.space12),
                                    const Text(
                                      'Admin Permissions',
                                      style: TextStyle(
                                        color: UColors.gray400,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const PermissionSelectionWidget(),
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
                          onPressed: () {},
                          label: const Text('Create Admin'),
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
}
