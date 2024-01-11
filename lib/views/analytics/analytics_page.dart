import 'dart:convert';
import 'dart:typed_data';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/columns/enforcer_performance_grid_columns.dart';
import 'package:u_traffic_admin/datagrids/columns/violation_aggregate_grid_columns.dart';
import 'package:u_traffic_admin/datagrids/enforcer_performance_data_grid_source.dart';
import 'package:u_traffic_admin/datagrids/violation_aggregate_data_grid_source.dart';
import 'package:u_traffic_admin/model/analytics/enforcer_performance.dart';
import 'package:u_traffic_admin/model/daily_dart_data.dart';
import 'package:u_traffic_admin/riverpod/aggregates/enforcer_performance..riverpod.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';
import 'package:u_traffic_admin/riverpod/aggregates/violations.dart';
import 'package:u_traffic_admin/views/analytics/widgets/dashboard_header.dart';
import 'package:u_traffic_admin/views/analytics/widgets/doughnut_chart.dart';
import 'package:u_traffic_admin/views/analytics/widgets/quick_info_row.dart';
import 'package:u_traffic_admin/views/common/widgets/date_range_picker.dart';
import 'package:universal_html/html.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  final _performanceTableKey = GlobalKey<SfDataGridState>();
  final _violationCountTableKey = GlobalKey<SfDataGridState>();
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final columnRange = ref.watch(columnRangeProvider);
    final PickerDateRange dailyTicketRange =
        ref.watch(dailyTicketRangeProvider);

    return PageContainer(
      route: Routes.analytics,
      appBar: AppBar(
        title: const Text("Analytics"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DashboardHeader(),
                  const SizedBox(height: 16),
                  const QuickInfoRow(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DoughnutChart(
                          provider: ticketByStatusAggregateProvider,
                          title: "Tickets by Status",
                          name: "Tickets by Status",
                          legendTitle: "Ticket Status",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DoughnutChart(
                          provider: paidVsUnpaidAggregateProvider,
                          title: "Paid and Unpaid Tickets",
                          name: "Paid and Unpaid Tickets",
                          legendTitle: "Ticket Status",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${columnRange.capitalize} Ticket Issued",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: columnRange == 'daily',
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: UDateRangePickerDialog(
                                            onSubmit: (value) {
                                              ref
                                                      .read(
                                                          dailyTicketRangeProvider
                                                              .notifier)
                                                      .state =
                                                  value as PickerDateRange;

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
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  "${dailyTicketRange.startDate!.toTimestamp.toAmericanDate}  -  ${dailyTicketRange.endDate!.toTimestamp.toAmericanDate}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: columnRange == 'by month',
                          child: Row(
                            children: [
                              StatusTypeDropDown(
                                statusList: const [
                                  "2023",
                                  "2024",
                                ],
                                onChanged: (value) {
                                  ref.read(yearProvider.notifier).state =
                                      value!;
                                },
                                value: ref.watch(yearProvider),
                              ),
                              const SizedBox(width: 16),
                              StatusTypeDropDown(
                                statusList: const [
                                  "January",
                                  "February",
                                  "March",
                                  "April",
                                  "May",
                                  "June",
                                  "July",
                                  "August",
                                  "September",
                                  "October",
                                  "November",
                                  "December",
                                ],
                                onChanged: (value) {
                                  ref.read(monthProvider.notifier).state =
                                      value!;
                                },
                                value: ref.watch(monthProvider),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: columnRange == 'by year',
                          child: StatusTypeDropDown(
                            statusList: const [
                              "2022",
                              "2023",
                              "2024",
                            ],
                            onChanged: (value) {
                              ref.read(yearProvider.notifier).state = value!;
                            },
                            value: ref.watch(yearProvider),
                          ),
                        ),
                        StatusTypeDropDown(
                          statusList: const [
                            "Daily",
                            "By month",
                            "By year",
                          ],
                          onChanged: (value) {
                            ref.read(columnRangeProvider.notifier).state =
                                value!.toLowerCase();
                          },
                          value: ref.watch(columnRangeProvider).capitalize,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: ref.watch(ticketsColumnChartProvider).when(
                          data: (data) {
                            if (columnRange == 'daily') {
                              data = data.reversed.toList();
                            }
                            return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                ColumnSeries<ColumnDataChart, String>(
                                  dataSource: data,
                                  xValueMapper: (ColumnDataChart data, _) =>
                                      columnRange == 'by year'
                                          ? data.column.parseMonth
                                          : DateFormat('MM-dd').format(
                                              DateTime.parse(data.column)),
                                  yValueMapper: (ColumnDataChart data, _) =>
                                      data.count,
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                  ),
                                )
                              ],
                            );
                          },
                          error: (error, stackTrace) => Center(
                            child: Text(
                              error.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: constraints.maxWidth,
                              child: Row(
                                children: [
                                  const Text(
                                    "Enforcer Performance",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  // SizedBox(
                                  //   width: 300,
                                  //   child: SwitchListTile(
                                  //     title: Text(
                                  //       _isTableView
                                  //           ? "Table View"
                                  //           : "Chart View",
                                  //       style: const TextStyle(
                                  //         fontSize: 12,
                                  //       ),
                                  //     ),
                                  //     value: _isTableView,
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         _isTableView = value;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: UColors.blue600,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onPressed: () =>
                                        _showExportDialog(_performanceTableKey),
                                    child: const Text('Export'),
                                  ),
                                ],
                              ),
                            ),
                            ref.watch(enforcerPerformanceStream).when(
                                  data: (data) {
                                    data.sort((a, b) => b.totalTickets
                                        .compareTo(a.totalTickets));
                                    return Expanded(
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        child: DataGridContainer(
                                          dataGridKey: _performanceTableKey,
                                          constraints: constraints,
                                          height: constraints.maxHeight - 130,
                                          source:
                                              EnforcerPerformanceDataGridSource(
                                            data,
                                          ),
                                          gridColumns:
                                              enforcerPerformanceGridColumns,
                                          dataCount: data.length,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) => Center(
                                    child: Text(
                                      error.toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: constraints.maxWidth,
                              child: Row(
                                children: [
                                  const Text(
                                    "Violation Count",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: UColors.blue600,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => _showExportDialog(
                                      _violationCountTableKey,
                                    ),
                                    child: const Text('Export'),
                                  ),
                                ],
                              ),
                            ),
                            ref.watch(violationsAggregate).when(
                                  data: (data) {
                                    data.sort(
                                        (a, b) => b.total.compareTo(a.total));
                                    return Expanded(
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        child: DataGridContainer(
                                          constraints: constraints,
                                          dataGridKey: _violationCountTableKey,
                                          height: constraints.maxHeight - 130,
                                          source:
                                              ViolationsAggregateDataGridSource(
                                            data,
                                          ),
                                          gridColumns:
                                              violationsAggregateGridColumns,
                                          dataCount: data.length,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) => Center(
                                    child: Text(
                                      error.toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _chartView(List<EnforcerPerformance> chartData) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomPanBehavior,
      primaryXAxis: CategoryAxis(
        autoScrollingMode: AutoScrollingMode.start,
        minimum: 10,
      ),
      series: <CartesianSeries>[
        ColumnSeries<EnforcerPerformance, String>(
          dataSource: chartData,
          xValueMapper: (EnforcerPerformance data, _) => data.name,
          yValueMapper: (EnforcerPerformance data, _) => data.totalTickets,
        ),
        ColumnSeries<EnforcerPerformance, String>(
          dataSource: chartData,
          xValueMapper: (EnforcerPerformance data, _) => data.name,
          yValueMapper: (EnforcerPerformance data, _) => data.totalPaidTickets,
        ),
        ColumnSeries<EnforcerPerformance, String>(
          dataSource: chartData,
          xValueMapper: (EnforcerPerformance data, _) => data.name,
          yValueMapper: (EnforcerPerformance data, _) =>
              data.totalUnpaidTickets,
        ),
        ColumnSeries<EnforcerPerformance, String>(
          dataSource: chartData,
          xValueMapper: (EnforcerPerformance data, _) => data.name,
          yValueMapper: (EnforcerPerformance data, _) =>
              data.totalTicketsCancelled,
        ),
        ColumnSeries<EnforcerPerformance, String>(
          dataSource: chartData,
          xValueMapper: (EnforcerPerformance data, _) => data.name,
          yValueMapper: (EnforcerPerformance data, _) =>
              data.totalTicketsExpired,
        ),
      ],
    );
  }

  void _showExportDialog(GlobalKey<SfDataGridState> key) {
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
                        await _createDocument(
                          key,
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
                        key,
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
    GlobalKey<SfDataGridState> key,
    Admin admin,
    String type,
    String checker,
    String title,
  ) async {
    final creatorName = '${admin.firstName} ${admin.lastName}';
    final employeeNo = admin.employeeNo;
    final uid = admin.id!;
    dynamic workbook = key.currentState!.exportToExcelWorkbook(
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
        key,
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
    GlobalKey<SfDataGridState> key,
    String author,
    String checker,
    String title,
  ) {
    PdfDocument document = PdfDocument();

    document.pageSettings.orientation = PdfPageOrientation.landscape;
    PdfPage pdfPage = document.pages.add();

    pdfPage.defaultLayer.graphics.drawString(
      'Public Order and Safety Division',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        16,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 32, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Urdaneta City, Pangasinan',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        12,
        style: PdfFontStyle.regular,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 54, 762, 100),
    );
    pdfPage.defaultLayer.graphics.drawString(
      'Ticket Report',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        22,
        style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      bounds: const Rect.fromLTWH(0, 0, 762, 100),
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
      bounds: const Rect.fromLTWH(0, 100, 762, 100),
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

    PdfGrid pdfGrid = key.currentState!.exportToPdfGrid(
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
        'Page $i of ${document.pages.count - 1}      Prepared by: Romar Macaraeg       Checked by: Marbert Cerda       ${DateTime.now().toTimestamp.toAmericanDate}',
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

final dailyTicketRangeProvider = StateProvider<PickerDateRange>((ref) {
  final now = DateTime.now();

  final startDate = DateTime(now.year, now.month, now.day - 15);
  final endDate = DateTime(now.year, now.month, now.day + 15);

  return PickerDateRange(startDate, endDate);
});
