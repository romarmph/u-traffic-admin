import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/complaints/widgets/attach_file_tile.dart';
import 'package:u_traffic_admin/views/complaints/widgets/attach_ticket_tile.dart';

final attachedTicketProvider = StateProvider<Ticket?>((ref) => null);

class ReplyComplaintPage extends ConsumerStatefulWidget {
  const ReplyComplaintPage({
    super.key,
    required this.title,
    required this.parentThread,
  });

  final String title;
  final String parentThread;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReplyComplaintPageState();
}

class _ReplyComplaintPageState extends ConsumerState<ReplyComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  List<Attachment> attachments = [];

  void _sendReply() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final description = _descriptionController.text;
    final ticket = ref.watch(attachedTicketProvider);
    final currentAdmin = ref.watch(currentAdminProvider);
    final ticketId = ticket != null ? ticket.id : "";

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Sending Reply',
      text: 'Please wait...',
    );

    final reply = Complaint(
      description: description,
      title: widget.title,
      attachedTicket: ticketId!,
      sender: currentAdmin.id!,
      createdAt: Timestamp.now(),
      isFromDriver: false,
      parentThread: widget.parentThread,
      status: 'open',
    );

    try {
      final docId = await ComplaintsDatabase.instance.addComplaint(reply);

      if (attachments.isNotEmpty) {
        final List<Attachment> uploadedAttachments = await Future.wait(
          attachments.map((file) => StorageService.instance.uploadFile(
                docId,
                file,
              )),
        );

        await ComplaintsDatabase.instance.insertAttachments(
          uploadedAttachments,
          docId,
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again later.',
      );
      return;
    }

    Navigator.of(navigatorKey.currentContext!).pop();

    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Reply sent successfully',
    );

    Navigator.of(navigatorKey.currentContext!).pop();
  }

  @override
  Widget build(BuildContext context) {
    final attachedTicket = ref.watch(attachedTicketProvider);
    return PageContainer(
      route: Routes.complaints,
      appBar: AppBar(
        title: const Text('Reply to Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: const UTextStyle().textlgfontnormal,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              enabled: false,
                              initialValue: widget.title,
                              decoration: const InputDecoration(
                                hintText: 'Type your title here...',
                                border: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: constraints.maxHeight * 0.5,
                              child: TextFormField(
                                controller: _descriptionController,
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  hintText: 'Type your reply here...',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your reply';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Text('Attach Ticket'),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          surfaceTintColor: UColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          title: const Text(
                                              'Select ticket to attach'),
                                          content: const TicketSelectionList(),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.add_rounded),
                                ),
                              ],
                            ),
                            attachedTicket != null
                                ? AttachTicketCard(ticket: attachedTicket)
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: UColors.gray100,
                                      border: Border.all(
                                        color: UColors.gray300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'No ticket attached',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: UColors.gray400,
                                      ),
                                    ),
                                  ),
                            Row(
                              children: [
                                const Text('Other Attachments'),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    final pickedFiles =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      readSequential: true,
                                      allowedExtensions: [
                                        'jpg',
                                        'jpeg',
                                        'png',
                                        'pdf',
                                        'doc',
                                        'docx',
                                      ],
                                    );

                                    if (pickedFiles == null) {
                                      return;
                                    }

                                    for (var file in pickedFiles.files) {
                                      if (file.size / 1e+6 > 25) {
                                        await QuickAlert.show(
                                          context: navigatorKey.currentContext!,
                                          type: QuickAlertType.error,
                                          title: 'Error',
                                          text:
                                              'File size must be less than 25MB',
                                        );
                                        return;
                                      }

                                      setState(() {
                                        attachments.add(Attachment(
                                          name: file.name,
                                          url: "",
                                          bytes: file.bytes!,
                                          type: file.name.split('.').last,
                                          size: file.size,
                                        ));
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.file_upload_outlined),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            attachments.isNotEmpty
                                ? Column(
                                    children: _buildAttachments(attachments),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: UColors.gray100,
                                      border: Border.all(
                                        color: UColors.gray300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'No attachments',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: UColors.gray400,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: UColors.blue500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: _sendReply,
                          child: const Text(
                            'Send Reply',
                            style: TextStyle(
                              color: UColors.white,
                            ),
                          ),
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

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onPressed: () {
            setState(() {
              this.attachments.remove(attachment);
            });
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }
}

class TicketSelectionList extends ConsumerWidget {
  const TicketSelectionList({
    super.key,
  });

  String? _getTicketIdentifier(Ticket ticket) {
    if (ticket.driverName!.isNotEmpty) {
      return ticket.driverName;
    } else if (ticket.plateNumber!.isNotEmpty) {
      return ticket.plateNumber;
    } else if (ticket.engineNumber!.isNotEmpty) {
      return ticket.engineNumber;
    } else if (ticket.chassisNumber!.isNotEmpty) {
      return ticket.chassisNumber;
    } else if (ticket.conductionOrFileNumber!.isNotEmpty) {
      return ticket.conductionOrFileNumber;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllTicketsForTicketPage).when(
      data: (data) {
        final deviceHeight = MediaQuery.of(context).size.height;

        return Container(
          height: deviceHeight * 0.7,
          width: 500,
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final ticket = data[index];
                    return ListTile(
                      title: Text(
                        '${ticket.ticketNumber} - ${_getTicketIdentifier(ticket)}',
                      ),
                      subtitle: Text(ticket.dateCreated.toAmericanDate),
                      trailing: const Icon(Icons.file_copy),
                      onTap: () {
                        ref.read(attachedTicketProvider.notifier).state =
                            ticket;
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
