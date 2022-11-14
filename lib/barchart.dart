import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  var borderProperty = const BorderSide(
    color: Colors.white,
    width: 3,
  );

  List<BarChartGroupData> barChartGroupData = [];

  @override
  Widget build(BuildContext context) {
    Map mp = ModalRoute.of(context)!.settings.arguments as Map;
    barChartGroupData = mp['barChartGroupData'];

    return BarChart(
      BarChartData(
        barGroups: barChartGroupData,
        alignment: BarChartAlignment.spaceAround,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameSize: 30,
            sideTitles: bottomTitles,
            axisNameWidget: const Text(
              'Day',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: borderProperty,
            bottom: borderProperty,
          ),
        ),
        gridData: FlGridData(show: false),
        maxY: 15,
      ),
    );
  }
}

SideTitles get bottomTitles {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: getTitles,
  );
}

// int i = 0;
Widget getTitles(double value, TitleMeta meta) {
  List<String> titles = ["M", "T", "W", "Th", "F", "S", "S"];
  // if (i > 6) i = 0;

  Widget text = Text(
    titles[value.toInt()],
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color:
          value.toInt() == 6 ? const Color.fromARGB(255, 28, 109, 231) : Colors.white,
    ),
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

