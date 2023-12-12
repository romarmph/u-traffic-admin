// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:u_traffic_admin/config/exports/exports.dart';

final dateRangeProvider = StateProvider<PickerDateRange?>((ref) => null);
final dateType = StateProvider<String>((ref) => 'Date Issued');
final violationFilter = StateProvider<List<Violation>>((ref) => []);

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  final searchController = TextEditingController();
  final _key = GlobalKey<SfDataGridState>();

  bool _isFilterNotClear() {
    return ref.watch(dateRangeProvider) != null ||
        ref.watch(ticketViewSearchQueryProvider).isNotEmpty ||
        ref.watch(ticketViewStatusQueryProvider) != 'all';
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text('Tickets'),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 22,
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                                side: const BorderSide(
                                  color: UColors.gray300,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: DateRangePickerDialog(
                                        onSubmit: (value) {
                                          if (value == null) {
                                            return;
                                          }
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.list_alt_rounded,
                                color: UColors.gray700,
                              ),
                              label: const Text(
                                'Filter by Violation',
                                style: TextStyle(
                                  color: UColors.gray700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 22,
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                                side: const BorderSide(
                                  color: UColors.gray300,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: DateRangePickerDialog(
                                        onSubmit: (value) {
                                          if (value == null) {
                                            return;
                                          }

                                          PickerDateRange dateRange =
                                              value as PickerDateRange;

                                          ref
                                              .read(dateRangeProvider.notifier)
                                              .state = dateRange;

                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.calendar_today_rounded,
                                color: UColors.gray700,
                              ),
                              label: const Text(
                                'Select Date Range',
                                style: TextStyle(
                                  color: UColors.gray700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            StatusTypeDropDown(
                              value: ref.watch(
                                ticketViewStatusQueryProvider,
                              ),
                              onChanged: (value) {
                                ref
                                    .read(
                                        ticketViewStatusQueryProvider.notifier)
                                    .state = value!;
                              },
                              statusList: const [
                                'all',
                                'unpaid',
                                'paid',
                                'cancelled',
                                // 'refunded',
                                // 'submitted',
                                'expired',
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Visibility(
                              visible: _isFilterNotClear(),
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 22,
                                    horizontal: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      USpace.space8,
                                    ),
                                  ),
                                  side: const BorderSide(
                                    color: UColors.gray300,
                                  ),
                                ),
                                onPressed: () {
                                  ref.read(dateRangeProvider.notifier).state =
                                      null;
                                  ref
                                      .read(ticketViewSearchQueryProvider
                                          .notifier)
                                      .state = '';
                                  ref
                                      .read(ticketViewStatusQueryProvider
                                          .notifier)
                                      .state = 'all';
                                  searchController.clear();
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Clear Filter'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  ref
                                      .read(ticketViewSearchQueryProvider
                                          .notifier)
                                      .state = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: UColors.gray300,
                                  ),
                                  suffixIcon: Visibility(
                                    visible: ref
                                        .watch(ticketViewSearchQueryProvider)
                                        .isNotEmpty,
                                    child: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(ticketViewSearchQueryProvider
                                                .notifier)
                                            .state = '';
                                        searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: UColors.gray300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            UElevatedButton(
                              onPressed: () async {
                                _showExportDialog();
                              },
                              child: const Text(
                                'Export Data',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: ref.watch(getAllTicketsForTicketPage).when(
                          data: (data) {
                            final query =
                                ref.watch(ticketViewSearchQueryProvider);

                            data = _searchTicket(data, query);

                            if (ref.watch(dateRangeProvider) != null) {
                              data = _filterTicketByDate(data);
                            }

                            return DataGridContainer(
                              onCellTap: (details) {
                                if (details.rowColumnIndex.rowIndex == 0) {
                                  return;
                                }
                                goToTicketView(
                                  data[details.rowColumnIndex.rowIndex - 1].id!,
                                  Routes.tickets,
                                );
                              },
                              height: constraints.maxHeight -
                                  60 -
                                  appBarHeight -
                                  100 -
                                  16,
                              dataGridKey: _key,
                              source: TicketDataGridSource(
                                ref: ref,
                                ticketList: data,
                                currentRoute: Routes.payment,
                              ),
                              dataCount: data.length,
                              gridColumns: ticketGridColumns,
                              constraints: constraints,
                            );
                          },
                          error: (error, stackTrace) {
                            return const Center(
                              child: Text('Error fetching tickets'),
                            );
                          },
                          loading: () => SizedBox(
                            height: constraints.maxHeight - 100 - 64,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
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

  List<Ticket> _searchTicket(List<Ticket> tickets, String query) {
    if (query.isNotEmpty) {
      return tickets.where((ticket) {
        query = query.toLowerCase();
        return ticket.ticketNumber.toString().contains(query) ||
            ticket.driverName!.toLowerCase().contains(query) ||
            ticket.licenseNumber!.toLowerCase().contains(query) ||
            ticket.enforcerName.toLowerCase().contains(query) ||
            ticket.dateCreated.toAmericanDate.toLowerCase().contains(query) ||
            ticket.ticketDueDate.toAmericanDate.toLowerCase().contains(query) ||
            ticket.plateNumber!.toLowerCase().contains(query) ||
            ticket.engineNumber!.toLowerCase().contains(query) ||
            ticket.chassisNumber!.toLowerCase().contains(query) ||
            ticket.conductionOrFileNumber!.toLowerCase().contains(query) ||
            ticket.issuedViolations
                .where((element) => element.violation
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isNotEmpty;
      }).toList();
    }
    return tickets;
  }

  List<Ticket> _filterTicketByDate(List<Ticket> tickets) {
    final type = ref.watch(dateType);
    final PickerDateRange? dateRange = ref.watch(dateRangeProvider);
    final DateTime startDate = dateRange!.startDate!;
    final DateTime? endDate = dateRange.endDate;

    if (type == 'Date Issued') {
      return tickets.where((ticket) {
        final ticketDate = ticket.dateCreated.toDate();

        if (endDate == null) {
          return ticketDate.isAfter(startDate) &&
              ticketDate.isBefore(
                startDate.add(
                  const Duration(
                    hours: 23,
                    minutes: 59,
                    seconds: 59,
                  ),
                ),
              );
        }

        return ticketDate.isAfter(startDate) && ticketDate.isBefore(endDate);
      }).toList();
    }
    return tickets.where((ticket) {
      final ticketDate = ticket.ticketDueDate.toDate();

      if (endDate == null) {
        return ticketDate.isAfter(startDate) &&
            ticketDate.isBefore(
              startDate.add(
                const Duration(
                  hours: 23,
                  minutes: 59,
                  seconds: 59,
                ),
              ),
            );
      }

      return ticketDate.isAfter(startDate) && ticketDate.isBefore(endDate);
    }).toList();
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String exportType = 'excel';
        return AlertDialog(
          content: const Text(
            'Export current data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
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
                      final admin = ref.watch(currentAdminProvider);
                      if (exportType == 'excel') {
                        await _createDocument(
                          admin,
                          'pdf',
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
                      if (exportType == 'excel') {
                        await _createDocument(
                          admin,
                          'excel',
                        );
                      }
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
        TicketGridFields.status,
      ],
    );

    workbook = _formatWorkbook(workbook);

    if (type == 'pdf') {
      workbook = _toDocument();
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

  PdfDocument _toDocument() {
    PdfDocument document = PdfDocument();

    document.pageSettings.orientation = PdfPageOrientation.landscape;
    PdfPage pdfPage = document.pages.add();
    PdfGrid pdfGrid = _key.currentState!.exportToPdfGrid(
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
        TicketGridFields.status,
      ],
    );
    pdfGrid.draw(page: pdfPage, bounds: const Rect.fromLTWH(0, 0, 0, 0));

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

class DateRangePickerDialog extends ConsumerWidget {
  const DateRangePickerDialog({
    super.key,
    this.onSubmit,
  });

  final dynamic Function(Object?)? onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
        color: UColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          StatusTypeDropDown(
            statusList: const [
              'Date Issued',
              'Due Date',
            ],
            onChanged: (value) {
              ref.read(dateType.notifier).state = value!;
            },
            value: ref.watch(dateType),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              onCancel: () {
                Navigator.pop(context);
              },
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
              ),
              onSubmit: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
