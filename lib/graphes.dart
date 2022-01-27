import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  // This widget is the root of your application.
  final url ="http://192.168.1.6:8082/FlutterTest";
  var _postsJson=[];
  var _valeur;
  void fetchPoste() async {
    try{
      final resp=await get(Uri.parse(url));
      final jsonData=jsonDecode(resp.body) as List;
      setState(() {
        _valeur=jsonData;
      });
    }catch(err){

    }

  }


  @override
  void initState() {
    fetchPoste();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 44,horizontal: 5),
            child: Center(
              child: Column(
                  children: <Widget>[
                    SfCircularChart(
                      title:
                      ChartTitle(text: 'localisation'),
                      legend:
                      Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          //maximumValue: 40000
                        )
                      ],

                    ),
                    SfCircularChart(
                      title:
                      ChartTitle(text: 'CORONAVIRUS (COVID-19) STATISTIQUES'),
                      legend:
                      Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          //maximumValue: 40000
                        )
                      ],

                    ),
                    SfCircularChart(
                      title:
                      ChartTitle(text: 'CORONAVIRUS (COVID-19) STATISTIQUES'),
                      legend:
                      Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          //maximumValue: 40000
                        )
                      ],

                    ),
                  ]
              ),
            ),
          ),
        )));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Centre à Tanger', 345),
      GDPData('Malabata à Tanger', 202),
      GDPData('Tanger', 183),
      GDPData('DeLaPlage à Tanger', 86),
      GDPData('Administratif à Tanger', 85),
      GDPData('TangerMedina à Tanger', 77),
      GDPData('TangerCityCenter à Tanger', 40),
      GDPData('Marjane à Tanger', 40),
      GDPData('Mozart à Tanger', 40),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}