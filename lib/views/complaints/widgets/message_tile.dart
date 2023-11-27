import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:path/path.dart' as path;
import 'package:u_traffic_admin/riverpod/database/complains_database_providers.dart';
import 'package:u_traffic_admin/views/complaints/widgets/attach_file_tile.dart';
import 'package:u_traffic_admin/views/complaints/widgets/attach_ticket_tile.dart';

class MessageTile extends ConsumerWidget {
  const MessageTile({
    super.key,
    required this.comlaint,
    required this.senderPhotoUrl,
    required this.senderName,
    this.isFromDriver = false,
  });

  final String comlaint;
  final String senderPhotoUrl;
  final String senderName;
  final bool isFromDriver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getComplaintByIdProvider(comlaint)).when(
      data: (complaint) {
        return ExpansionTileCard(
          baseColor: UColors.white,
          expandedColor: UColors.white,
          initiallyExpanded: true,
          elevation: 0,
          leading: ClipOval(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: UColors.gray300,
              child: CachedNetworkImage(
                imageUrl: senderPhotoUrl,
              ),
            ),
          ),
          title: Text(
            complaint.title,
            style: const UTextStyle().textlgfontbold,
          ),
          subtitle: Row(
            children: [
              Text(
                isFromDriver ? 'Sent by' : 'Replied by',
                style: const UTextStyle().textsmfontmedium,
              ),
              const SizedBox(width: 8),
              Text(
                senderName,
                style: const UTextStyle().textsmfontmedium,
              ),
              const SizedBox(width: 8),
              const Text(
                'at',
              ),
              const SizedBox(width: 8),
              Text(
                complaint.createdAt.toAmericanDate,
                style: const UTextStyle().textsmfontmedium,
              ),
            ],
          ),
          initialElevation: 0,
          shadowColor: Colors.transparent,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                complaint.description,
                style: const UTextStyle().textsmfontmedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              width: double.infinity,
              child: const Text(
                'Attached Ticket',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: complaint.attachedTicket.isEmpty
                  ? Container(
                      width: 300,
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
                    )
                  : ref
                      .watch(
                          getTicketByIdFutureProvider(complaint.attachedTicket))
                      .when(
                      data: (ticket) {
                        return AttachTicketCard(
                          ticket: ticket,
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Text(
                            error.toString(),
                            style: const UTextStyle().textlgfontbold,
                          ),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
            ),
            complaint.attachments.isNotEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildAttachments(complaint.attachments),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      width: double.infinity,
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
                  ),
          ],
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: const UTextStyle().textlgfontbold,
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

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onTiletap: () {
            _downloadFile(
              attachment.url,
              attachment.name,
            );
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }

  void _downloadFile(String url, String fileName) async {
    final result = await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.confirm,
      title: 'Download File',
      text: 'Are you sure to download this file?',
      onConfirmBtnTap: () {
        Navigator.of(navigatorKey.currentContext!).pop(true);
      },
    );

    if (result != true) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Downloading',
      text: 'Please wait...',
    );

    try {
      const directory = '/storage/emulated/0/Download';
      final time = DateTime.now().millisecondsSinceEpoch;
      final fullPath = path.join(directory,
          '${fileName.split('.').first}-$time.${fileName.split('.').last}');
      await Directory(directory).create(recursive: true);

      final res = await get(Uri.parse(url));
      File(fullPath).writeAsBytes(res.bodyBytes);
      Navigator.of(navigatorKey.currentContext!).pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('File downloaded successfully'),
        ),
      );
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again later.',
      );
    }
  }
}
