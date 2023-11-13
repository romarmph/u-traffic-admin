// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  final searchController = TextEditingController();
  final _key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
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
                          StatusTypeDropDown(
                            value: ref.watch(
                              ticketViewStatusQueryProvider,
                            ),
                            onChanged: (value) {
                              ref
                                  .read(ticketViewStatusQueryProvider.notifier)
                                  .state = value!;
                            },
                            statusList: const [
                              'all',
                              'unpaid',
                              'paid',
                              'cancelled',
                              'refunded',
                              'submitted',
                              'expired',
                            ],
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
                                    .read(
                                        ticketViewSearchQueryProvider.notifier)
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
                          UElevatedButton(
                            onPressed: () async {
                              final admin = ref.watch(currentAdminProvider);
                              await _createExcel(
                                '${admin.firstName} ${admin.lastName}',
                                admin.employeeNo,
                                admin.id!,
                              );
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
                          return DataGridContainer(
                            dataGridKey: _key,
                            source: TicketDataGridSource(
                              ticketList: _searchTicket(data, query),
                              currentRoute: Routes.payment,
                            ),
                            dataCount: _searchTicket(data, query).length,
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
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      ),
                ),
              ],
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
            ticket.ticketDueDate.toAmericanDate.toLowerCase().contains(query);
      }).toList();
    }
    return tickets;
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Excel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createExcel(
    String creatorName,
    String employeeNo,
    String uid,
  ) async {
    final workbook = _key.currentState!.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveSync();
    workbook.dispose();

    final userName = creatorName.toLowerCase().replaceAll(' ', '-');
    final date = DateTime.now().millisecondsSinceEpoch;
    final fileName = "$userName-$employeeNo-$date.xlsx";

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

  Future<void> _createPdf() async {
    final PdfDocument pdfDocument = _key.currentState!.exportToPdfDocument();

    final List<int> bytes = pdfDocument.saveSync();
    pdfDocument.dispose();

    final fileName = DateTime.now().toIso8601String().replaceAll('.', '-');

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "export-$fileName.pdf")
      ..click();
  }
}
