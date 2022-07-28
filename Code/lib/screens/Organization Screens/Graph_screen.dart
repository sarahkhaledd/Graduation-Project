import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Graph_screen extends StatelessWidget {
  final int MoneyRequests;
  final int ClothesRequests;
  final int DevicesRequests;
  final int BooksRequests;
  final int NumberOfRequests;

  Graph_screen(
      {Key? key,
      required this.MoneyRequests,
      required this.ClothesRequests,
      required this.DevicesRequests,
      required this.BooksRequests,
      required this.NumberOfRequests})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Money Donation": MoneyRequests.toDouble(),
      "Clothes Donation": ClothesRequests.toDouble(),
      "Devices Donation": DevicesRequests.toDouble(),
      "Books Donation": BooksRequests.toDouble(),
    };
    final colorList = <Color>[
      const Color(0xfffdcb6e),
      const Color(0xff0984e3),
      const Color(0xffe17055),
      const Color(0xff6c5ce7),
    ];
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "Pie Chart",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: Column(children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 0,
          ),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Text(
          "Total number of requests are " + NumberOfRequests.toString() + " requests.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }
}
