// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AttachFileTile extends ConsumerWidget {
  const AttachFileTile({
    super.key,
    required this.attachment,
    this.onTiletap,
    this.onPressed,
  });

  final Attachment attachment;
  final VoidCallback? onPressed;
  final VoidCallback? onTiletap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.only(
        left: 4,
      ),
      decoration: BoxDecoration(
        color: UColors.blue400,
        border: Border.all(
          color: UColors.gray200,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: UColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: ListTile(
          onTap: () {
            _downloadFile(attachment.url, attachment.name);
          },
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 4,
          ),
          visualDensity: VisualDensity.compact,
          tileColor: UColors.gray100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            attachment.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            '${(attachment.size / 1e+6).toStringAsFixed(2)} MB',
          ),
          minLeadingWidth: 0,
          trailing: onPressed == null
              ? null
              : IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.remove_circle,
                    color: UColors.red500,
                  ),
                ),
        ),
      ),
    );
  }

  void _downloadFile(String fileUrl, String fileName) async {
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
      final response = await http.get(Uri.parse(fileUrl));
      final bytes = response.bodyBytes;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = fileName;
      html.document.body!.children.add(anchor);

      anchor.click();

      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);

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
