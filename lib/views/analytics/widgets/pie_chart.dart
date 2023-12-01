import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PieChartWidget extends ConsumerWidget {
  const PieChartWidget({
    super.key,
    required this.provider,
    required this.title,
    required this.name,
    required this.legendTitle,
  });

  final StreamProvider provider;
  final String title;
  final String name;
  final String legendTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: UColors.gray200,
        ),
      ),
      child: ref.watch(provider).when(
        data: (pieChartData) {
          return SfCircularChart(
            title: ChartTitle(
              text: title,
            ),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
              title: LegendTitle(
                text: legendTitle,
              ),
            ),
            series: <CircularSeries>[
              PieSeries<PieChartData, String>(
                name: name,
                dataSource: pieChartData,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
                legendIconType: LegendIconType.seriesType,
                dataLabelMapper: (datum, index) =>
                    "${datum.name.toUpperCase()} (${datum.count}) ${(datum.count / pieChartData.map((e) => e.count).reduce((value, element) => value + element) * 100).toStringAsFixed(1)}%",
                xValueMapper: (PieChartData data, _) => data.name,
                yValueMapper: (PieChartData data, _) => data.count,
                enableTooltip: true,
              ),
            ],
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
      ),
    );
  }
}
