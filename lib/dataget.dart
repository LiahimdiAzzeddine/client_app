import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'Kmeans.dart';


class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}
class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

class _DetailsState extends State<Details> {
  late List<GDPData> _chartData;
  late List<GDPData> _chartData2;
  late List<GDPData> _chartData3;
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehavior2;
  final url ="http://192.168.1.6:8080/FlutterTest";
  final url2 ="http://192.168.1.6:8080/FlutterDataPrices";
  final url3 ="http://192.168.1.6:8080/Kmeans";
  var _postsJson=[];
  var _scatterJson=[];
  var _getprieces=[];
  void fetchPrice() async {
    try{
      final resp=await get(Uri.parse(url2));
      final jsonData=jsonDecode(resp.body) as List;
      setState(() {
        _getprieces=jsonData;
        _chartData2 = [
          GDPData('Mozart',_getprieces[0]['item8'].toInt()!),
          GDPData('Malabata',_getprieces[0]['item9'].toInt()!),
          GDPData('Centre de Tanger',_getprieces[0]['item2'].toInt()!),
          GDPData('Tanger City Center',_getprieces[0]['item3'].toInt()!),
          GDPData('Médina',_getprieces[0]['item4'].toInt()!),
          GDPData('Administratif',_getprieces[0]['item5'].toInt()!),
          GDPData('De La Plage',_getprieces[0]['item6'].toInt()!),
          GDPData('Marjane',_getprieces[0]['item7'].toInt()!),
          GDPData('Tanger',_getprieces[0]['item1'].toInt()!)
        ];

      });
    }catch(err){
    }

  }
  void fetchPoste() async {
    try{
      final resp=await get(Uri.parse(url));
      final jsonData=jsonDecode(resp.body) as List;
      setState(() {
        _postsJson=jsonData;
        _chartData = [
          GDPData('DeLaPlage',_postsJson[0]['DeLaPlage']!),
          GDPData('Mozart', _postsJson[0]['Mozart']!),
          GDPData('Tanger',_postsJson[0]['Tanger']!),
          GDPData('Malabata',_postsJson[0]['Malabata']!),
          GDPData('Marjane',_postsJson[0]['Marjane']!),
          GDPData('Center', _postsJson[0]['Center']!),
          GDPData('Medina',_postsJson[0]['Medina']!),
          GDPData('Administratif',_postsJson[0]['Administratif']!),
          GDPData('CityCenter',_postsJson[0]['CityCenter']!),
        ];
        _tooltipBehavior = TooltipBehavior(enable: true);
      });
    }catch(err){
    }
  }
  void Scatter() async {
    try{
      final resp=await get(Uri.parse(url3));
      final jsonData=jsonDecode(resp.body) as List;
      setState(() {
        _scatterJson=jsonData;
        _chartData3 = [
          GDPData(_scatterJson[0]['price'].toString(),_scatterJson[0]['sise']!),
        ];
        var num = 1;
        for( var i = num ;i<50; i++ ) {
          _chartData3.add(GDPData(_scatterJson[i]['price'].toString(),_scatterJson[i]['sise']!));

        }
        _tooltipBehavior = TooltipBehavior(enable: true);
      });
    }catch(err){
    }
  }
  @override
  void initState() {
    fetchPoste();
    fetchPrice();
    Scatter();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    super.initState();
  }
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.blue,
            title: Text(
              "Location de biens immobiliers à Tanger",
              style: TextStyle(
                fontSize: 15,
                //fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

          ),
          //-------------------------------------------------fin AppBar ----------------------------------------

          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 15),
              child: Center(
                child: Column(
                    children: <Widget>[
                      Container(
                        child: Text("Visualisation",style: TextStyle(
                          fontSize: 26,
                          //fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),),
                      ),
                      SfCircularChart(
                        title:
                        ChartTitle(text: "Monopoly de localisation"),
                        legend:
                        Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          DoughnutSeries<GDPData, String>(
                            dataSource: _chartData,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            //maximumValue: 40000
                          )
                        ],

                      ),

                      SfCartesianChart(title: ChartTitle(text:"Nombre d'annonces par Localisation à Tanger" ),
                        series: <ChartSeries>[
                          BarSeries<GDPData, String>(
                              dataSource: _chartData,
                              xValueMapper: (GDPData data, _) => data.continent,
                              yValueMapper: (GDPData data, _) => data.gdp)
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                      ),
                      Container(
                        child: Text("On note la présence d'un grand nombre de biens immobiliers au centre de Tange",style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SfCartesianChart(title: ChartTitle(text:"Prix moyen par Localisation à Tanger"),
                        series: <ChartSeries>[
                          BarSeries<GDPData, String>(
                              dataSource: _chartData2,
                              xValueMapper: (GDPData data, _) => data.continent,
                              yValueMapper: (GDPData data, _) => data.gdp)
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                      ),
                      Container(
                        child: Text("On note que le prix moyen au centre de Tanger est très élevé par rapport aux autres régions",style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      RaisedButton(
                        onPressed: (){
                          _Statistque(context);
                        },
                        shape: StadiumBorder(),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        child: Text("K-Means",style: TextStyle(fontSize: 22.0),),
                        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 80.0),
                        elevation: 0.0,

                      )
                    ]
                ),
              ),
            ),
          )

      ),

    );

  }
  void _Statistque(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return const Kmeans(
      );
    });
    Navigator.of(context).push(route);
  }
}


