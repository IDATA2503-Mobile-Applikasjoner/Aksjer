import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:aksje_app/models/stock_history.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

/// Builds a stock chart widget displaying a stock's historical data.
///
/// This function creates a visual representation of the stock's price history
/// using a line chart and a sparkline chart from the Syncfusion Flutter Charts package.
/// It shows the price movement over time, with different colors indicating
/// increases or decreases in price.
///
/// [stockHistories] is a list of StockHistory objects containing the historical data of the stock.
Widget buildStockChart(List<StockHistory> stockHistories) {
  return Column(
    children: [
      // SfCartesianChart is used to create a detailed line chart.
      SfCartesianChart(
        primaryXAxis: CategoryAxis(), // X-axis is categorized by dates.
        trackballBehavior: TrackballBehavior(
          enable: true,
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
          enableSelectionZooming: true,
          enableMouseWheelZooming: true,
        ),
        series: <ChartSeries<StockHistory, String>>[
          LineSeries<StockHistory, String>(
            dataSource: stockHistories, // Data source for the chart.
            xValueMapper: (StockHistory history, _) =>
                history.date, // Mapping the date for the X-axis.
            yValueMapper: (StockHistory history, _) =>
                history.price, // Mapping the price for the Y-axis.
            name: "Price", // Name of the series.
            // The color of each point in the line chart is determined by the price change.
            pointColorMapper: (StockHistory history, _) {
              int index = stockHistories.indexOf(history);
              if (index == 0 ||
                  stockHistories[index].price <
                      stockHistories[index - 1].price) {
                return Colors.red; // Red for price decrease.
              } else {
                return Colors.green; // Green for price increase.
              }
            },
          ),
        ],
      ),
      // Expanded widget with a SfSparkLineChart to show the same data in a condensed form.
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfSparkLineChart.custom(
            trackball: const SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap),
            marker: const SparkChartMarker(
                displayMode: SparkChartMarkerDisplayMode.all),
            labelDisplayMode: SparkChartLabelDisplayMode.all,
            xValueMapper: (int index) =>
                stockHistories[index].date, // Mapping the date for the X-axis.
            yValueMapper: (int index) => stockHistories[index]
                .price, // Mapping the price for the Y-axis.
          ),
        ),
      ),
    ],
  );
}
