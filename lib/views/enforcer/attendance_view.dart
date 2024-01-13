import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/attendance_data_grid_source.dart';
import 'package:u_traffic_admin/datagrids/columns/attendance_grid_columns.dart';
import 'package:u_traffic_admin/riverpod/database/attendance_database_providers.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:universal_html/html.dart';

class EnforcerAttendancePage extends ConsumerStatefulWidget {
  const EnforcerAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnforcerAttendancePage();
}

class _EnforcerAttendancePage extends ConsumerState<EnforcerAttendancePage> {
  final _key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.enforcerAttendance,
      appBar: AppBar(
        title: const Text("Enforcers"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Attendance",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              USpace.space8,
                            ),
                          ),
                          padding: const EdgeInsets.all(USpace.space12),
                        ),
                        onPressed: _showExportDialog,
                        child: const Text('Export Data'),
                      ),
                      const SizedBox(width: USpace.space16),
                      OutlinedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: ref.watch(dayProvider).toDate(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2025),
                          );
                          if (date != null) {
                            ref.read(dayProvider.notifier).state =
                                Timestamp.fromDate(date);
                          }
                        },
                        child: Text(
                          DateFormat.yMMMMd()
                              .format(ref.watch(dayProvider).toDate()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: USpace.space16),
                  Expanded(
                    child: ref
                        .watch(attendanceProvider(ref.watch(dayProvider)))
                        .when(
                          data: (attendance) {
                            return DataGridContainer(
                              dataGridKey: _key,
                              constraints: constraints,
                              source: AttendanceDataGridSource(
                                attendance,
                              ),
                              gridColumns: attendanceGridColumns,
                              dataCount: attendance.length,
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stackTrace) => Center(
                            child: Text(error.toString()),
                          ),
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

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final formKey = GlobalKey<FormState>();
        final titleController = TextEditingController();
        final checkerController = TextEditingController();
        return AlertDialog(
          surfaceTintColor: UColors.white,
          content: SizedBox(
            width: 500,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Export current data',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: checkerController,
                    decoration: const InputDecoration(
                      labelText: 'Checker',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Checker is required';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: UColors.blue600,
                      foregroundColor: UColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          USpace.space8,
                        ),
                      ),
                      padding: const EdgeInsets.all(USpace.space16),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final admin = ref.watch(currentAdminProvider);
                        print(checkerController.text);
                        await _createDocument(
                          admin,
                          'pdf',
                          checkerController.text,
                          titleController.text,
                        );
                      }
                    },
                    child: const Text('PDF'),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: UColors.green600,
                      foregroundColor: UColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          USpace.space8,
                        ),
                      ),
                      padding: const EdgeInsets.all(USpace.space16),
                    ),
                    onPressed: () async {
                      final admin = ref.watch(currentAdminProvider);
                      await _createDocument(
                        admin,
                        'excel',
                        checkerController.text,
                        titleController.text,
                      );
                    },
                    child: const Text('Excel'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createDocument(
    Admin admin,
    String type,
    String checker,
    String title,
  ) async {
    final creatorName = '${admin.firstName} ${admin.lastName}';
    final employeeNo = admin.employeeNo;
    final uid = admin.id!;
    dynamic workbook = _key.currentState!.exportToExcelWorkbook(
      exportColumnWidth: true,
      cellExport: (details) {
        if (details.cellType == DataGridExportCellType.row) {
          if (details.columnName == TicketGridFields.ticketDueDate ||
              details.columnName == TicketGridFields.dateCreated) {}
        }
      },
      excludeColumns: [
        TicketGridFields.actions,
        // TicketGridFields.status,
      ],
    );

    workbook = _formatWorkbook(workbook);

    if (type == 'pdf') {
      workbook = _toDocument(
        '${admin.firstName} ${admin.lastName}',
        checker,
        title,
      );
    }

    final List<int> bytes = workbook.saveSync();
    workbook.dispose();

    final fileType = type == 'excel' ? 'xlsx' : 'pdf';

    final userName = creatorName.toLowerCase().replaceAll(' ', '-');
    final date = DateTime.now().millisecondsSinceEpoch;
    final fileName = "$userName-$employeeNo-$date.$fileType";

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();

    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child("exports/$fileName");
    final Uint8List data = Uint8List.fromList(bytes);
    final uploadTask = fileRef.putData(data);
    await uploadTask.whenComplete(() async {
      final downloadUrl = await fileRef.getDownloadURL();

      final firestoreInstance = FirebaseFirestore.instance;
      await firestoreInstance.collection('files').add(
            DataExports(
              fileName: fileName,
              url: downloadUrl,
              creatorName: creatorName,
              createdAt: Timestamp.now(),
              createdBy: uid,
            ).toJson(),
          );
    });
  }

  PdfDocument _toDocument(
    String author,
    String checker,
    String title,
  ) {
    PdfDocument document = PdfDocument();

    document.pageSettings.orientation = PdfPageOrientation.landscape;
    PdfPage pdfPage = document.pages.add();

    pdfPage.defaultLayer.graphics.drawString(
      'Republic of the Philippines',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        16,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 32, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Province of Pangasinan',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        14,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 54, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Public Order and Safety Division',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        20,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 72, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Urdaneta City, Pangasinan',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        14,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 96, 762, 100),
    );

    pdfPage.defaultLayer.graphics.drawString(
      title,
      PdfStandardFont(
        PdfFontFamily.helvetica,
        22,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 150, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Date prepared: ${DateTime.now().toTimestamp.toAmericanDate}',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        12,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
      ),
      bounds: const Rect.fromLTWH(0, 350, 200, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Prepared by',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        12,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
      ),
      bounds: const Rect.fromLTWH(0, 400, 200, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      author,
      PdfStandardFont(
        PdfFontFamily.helvetica,
        14,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
      ),
      bounds: const Rect.fromLTWH(0, 420, 200, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Checked by',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        12,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
      ),
      bounds: const Rect.fromLTWH(200, 400, 200, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      checker,
      PdfStandardFont(
        PdfFontFamily.helvetica,
        14,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
      ),
      bounds: const Rect.fromLTWH(200, 420, 200, 100),
    );

    PdfGrid pdfGrid = _key.currentState!.exportToPdfGrid(
      exportTableSummaries: true,
      cellExport: (details) {
        if (details.cellType == DataGridExportCellType.columnHeader) {
          details.pdfCell.style.font = PdfStandardFont(
            PdfFontFamily.helvetica,
            8,
            style: PdfFontStyle.regular,
          );
        }
        if (details.cellType == DataGridExportCellType.row) {
          if (details.columnName == TicketGridFields.ticketDueDate ||
              details.columnName == TicketGridFields.dateCreated) {
            details.pdfCell.value = details.cellValue
                .toString()
                .toDateTime
                .toTimestamp
                .toAmericanDate;
          }
        }
      },
      fitAllColumnsInOnePage: true,
      excludeColumns: [
        TicketGridFields.actions,
        // TicketGridFields.status,
      ],
    );

    pdfGrid.draw(
      page: pdfPage,
      format: PdfLayoutFormat(
        layoutType: PdfLayoutType.paginate,
      ),
      graphics: pdfPage.graphics,
      bounds: const Rect.fromLTWH(0, 515, 0, 0),
    );

    int length = document.pages.count;

    for (int i = 0; i < length; i++) {
      if (i == 0) continue;

      PdfPage page = document.pages[i];
      page.graphics.drawString(
        'Page $i of ${document.pages.count - 1}      Prepared by: Romar Macaraeg       Checked by: $checker       ${DateTime.now().toTimestamp.toAmericanDate}',
        PdfStandardFont(
          PdfFontFamily.helvetica,
          8,
          style: PdfFontStyle.regular,
        ),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
        ),
        bounds: const Rect.fromLTWH(0, 507, 500, 515),
      );
    }

    return document;
  }

  excel.Workbook _formatWorkbook(excel.Workbook workbook) {
    final sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1:Z1').cellStyle.backColor = '#F2F2F2';
    sheet.getRangeByName('A1:Z1').cellStyle.bold = true;
    sheet.getRangeByName('A1:Z1').cellStyle.fontSize = 12;
    final excel.Style style = workbook.styles.add('Style1');
    style.hAlign = excel.HAlignType.center;
    style.vAlign = excel.VAlignType.center;

    return workbook;
  }
}

final dayProvider = StateProvider<Timestamp>((ref) {
  return Timestamp.fromDate(DateTime.now());
});
