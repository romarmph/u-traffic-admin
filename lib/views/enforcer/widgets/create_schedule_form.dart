import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateEnforcerSchedForm extends ConsumerStatefulWidget {
  const CreateEnforcerSchedForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateEnforcerSchedFormState();
}

class CreateEnforcerSchedFormState
    extends ConsumerState<CreateEnforcerSchedForm> {
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_a_photo_rounded),
                                  label: const Text('Upload Photo'),
                                ),
                              ],
                            ),
                            const SizedBox(width: USpace.space16),
                            Expanded(
                              child: Form(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: EnforcerFormField(
                                            label: 'First Name',
                                            hintText: 'Ex. Juan',
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 3,
                                          child: EnforcerFormField(
                                            label: 'Middle Name',
                                            hintText: 'Ex. Andres',
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 3,
                                          child: EnforcerFormField(
                                            hintText: 'Ex. Dela Cruz',
                                            label: 'Last Name',
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 1,
                                          child: EnforcerFormField(
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
                                            child: EnforcerFormField(
                                              hintText: '',
                                              label: 'Employee No.',
                                              onChanged: (value) async {},
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: USpace.space12),
                                        Expanded(
                                          flex: 3,
                                          child: Form(
                                            child: EnforcerFormField(
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
                                          child: Container(),
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
                          onPressed: () {},
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
}
