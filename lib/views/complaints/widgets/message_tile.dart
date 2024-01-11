import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:path/path.dart' as path;

import 'package:u_traffic_admin/views/complaints/widgets/attach_file_tile.dart';

class MessageTile extends ConsumerWidget {
  const MessageTile({
    super.key,
    required this.title,
    required this.description,
    required this.senderPhotoUrl,
    required this.senderName,
    required this.attachments,
    this.isFromDriver = false,
    this.email,
    this.phone,
    required this.createdAt,
  });

  final String title;
  final String description;
  final String senderPhotoUrl;
  final String senderName;
  final bool isFromDriver;
  final List<Attachment> attachments;
  final String? email;
  final String? phone;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isFromDriver) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: UColors.gray50,
                      border: Border.all(
                        color: UColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          style: const UTextStyle().textsmfontbold,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const UTextStyle().textbasefontnormal,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 4),
                        ..._buildAttachments(attachments),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    createdAt.toAmericanDate,
                    style: const UTextStyle().textxsfontmedium.copyWith(
                          color: UColors.gray400,
                        ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: UColors.gray300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: senderPhotoUrl,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: UColors.gray300,
              borderRadius: BorderRadius.circular(40),
            ),
            child: CachedNetworkImage(
              imageUrl: senderPhotoUrl,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: UColors.gray50,
                    border: Border.all(
                      color: UColors.gray100,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: const UTextStyle().textsmfontbold,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const UTextStyle().textbasefontnormal,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      ..._buildAttachments(attachments),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  createdAt.toAmericanDate,
                  style: const UTextStyle().textxsfontmedium.copyWith(
                        color: UColors.gray400,
                      ),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ],
      ),
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
