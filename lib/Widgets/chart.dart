import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calory/Database/databaseQueries.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map> list = [];
  List<ChartData> dataSource = [];
  void getData() async {
    print('chart get start');
    list = await chartData();
    list = list.reversed.toList();
    for (int i = 0; i < list.length; i++) {
      print((list[i])['calorieburned']);
      print((list[i])['timestamp']);
      setState(() {
        dataSource.add(ChartData(
            day: DateTime.parse((list[i])['timestamp']),
            calories: (list[i])['calorieburned']));
      });
    }
    print('chart get end');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
          enable: true,
          decimalPlaces: 1,
          shouldAlwaysShow: true,
          header: 'Calories Burned',
          color: Colors.white,
          canShowMarker: true,
          textStyle: TextStyle(
            color: Color(0xff29D6E1),
          )),
      // trackballBehavior: TrackballBehavior(
      //     enable: true
      // ),
      plotAreaBorderWidth: 0,
      borderColor: Colors.transparent,
      borderWidth: 0,
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: false,
        enablePinching: false,
        enableSelectionZooming: true,
        // maximumZoomLevel: 3,
      ),

      primaryXAxis: DateTimeAxis(
          majorGridLines: MajorGridLines(width: 0), dateFormat: DateFormat.d()),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      series: [
        SplineSeries<ChartData, DateTime>(
            width: 3,
            color: Color(0xff29D6E1),
            dataSource: dataSource,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.calories),
      ],
    );
  }
}

class ChartData {
  DateTime day;
  int calories;
  ChartData({this.calories = 0, required this.day});
}
