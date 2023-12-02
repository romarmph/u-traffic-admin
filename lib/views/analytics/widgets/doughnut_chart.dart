import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class DoughnutChart extends ConsumerWidget {
  const DoughnutChart({
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
      ),
      child: ref.watch(provider).when(
        data: (pieChartData) {
          bool allDataEmpty =
              pieChartData.every((element) => element.count == 0);

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
            annotations: [
              CircularChartAnnotation(
                widget: Text(
                  pieChartData
                      .map((e) => e.count)
                      .reduce((value, element) => value + element)
                      .toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                pointColorMapper: (datum, index) {
                  switch (index) {
                    case 1:
                      return UColors.blue400;
                    case 2:
                      return UColors.green400;
                    case 3:
                      return UColors.red400;
                    case 4:
                      return UColors.yellow400;
                    case 5:
                      return UColors.purple400;
                    case 6:
                      return UColors.orange400;
                    case 7:
                      return UColors.pink400;
                    case 8:
                      return UColors.indigo400;
                    case 9:
                      return UColors.teal400;
                  }
                  return null;
                },
                name: name,
                emptyPointSettings: EmptyPointSettings(
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                ),
                dataSource: pieChartData,
                dataLabelSettings: DataLabelSettings(
                  isVisible: !allDataEmpty,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
                legendIconType: LegendIconType.seriesType,
                dataLabelMapper: (datum, index) =>
                    "${datum.name.toUpperCase()} (${datum.count}) ${(datum.count / pieChartData.map((e) => e.count).reduce((value, element) => value + element) * 100).toStringAsFixed(1)}%",
                xValueMapper: (ChartData data, _) => data.name,
                yValueMapper: (ChartData data, _) => data.count,
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
