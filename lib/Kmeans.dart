import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:syncfusion_flutter_charts/charts.dart';


class Kmeans extends StatefulWidget {
  const Kmeans({Key? key}) : super(key: key);

  @override
  _KmeansState createState() => _KmeansState();
}
class GDPData {
  GDPData(this.continent, this.gdp);
  final int continent;
  final int gdp;
}
class SalesData{
  SalesData(this.x,this.y);
  final String x;
  final int y;
}

class _KmeansState extends State<Kmeans> {

  late List<GDPData> _chartData3;
  late List<GDPData> _chartData2;
  late List<GDPData> _chartData1;


  final url3 ="http://192.168.1.6:8080/Kmeans";

  var _scatterJson=[];


  void Scatter() async {
    try{
      final resp=await get(Uri.parse(url3));
      final jsonData=jsonDecode(resp.body) as List;
      setState(() {
        _scatterJson=jsonData;
        _chartData3 = [
        ];
        _chartData2 = [
        ];
        _chartData1 = [
        ];
        var num = 0;
        var x = 0;
        var y = 0;
        var z = 0;
        for( var i = num ;i<_scatterJson.length; i++ ) {
          if(_scatterJson[i]['cluster'].toInt()==0 && x<55){
            _chartData1.add(GDPData(_scatterJson[i]['price'].toInt(),_scatterJson[i]['sise'].toInt()!));
            x=x+1;
          }
          if(_scatterJson[i]['cluster'].toInt()==1 && y<30){
            _chartData2.add(GDPData(_scatterJson[i]['price'].toInt(),_scatterJson[i]['sise'].toInt()!));
            y=y+1;
          }
          if(_scatterJson[i]['cluster'].toInt()==2 && z<45) {
            _chartData3.add(GDPData(_scatterJson[i]['price'].toInt(), _scatterJson[i]['sise'].toInt()!));
            z=z+1;
          }

        }
      });
    }catch(err){
    }
  }
  @override
  void initState() {
    Scatter();
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

                      SfCartesianChart(title: ChartTitle(text:"Kmeans prices - size" ),

                        series: <ChartSeries>[
                          ScatterSeries<GDPData, int>(
                            dataSource: _chartData1,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            markerSettings: MarkerSettings(
                              isVisible: true,
                              shape: DataMarkerType.circle,
                              color: Colors.red,
                              borderColor: Colors.green,
                              borderWidth: 2,
                            ),
                          ),
                          ScatterSeries<GDPData, int>(
                            dataSource: _chartData2,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            markerSettings: MarkerSettings(
                              isVisible: true,
                              shape: DataMarkerType.circle,
                              color: Colors.blueAccent,
                              borderColor: Colors.green,
                              borderWidth: 2,
                            ),
                          ),
                          ScatterSeries<GDPData, int>(
                            dataSource: _chartData3,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            markerSettings: MarkerSettings(
                              isVisible: true,
                              shape: DataMarkerType.circle,
                              color: Colors.yellow,
                              borderColor: Colors.green,
                              borderWidth: 2,
                            ),
                          ),
                        ],



                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                      ),
                    ]
                ),
              ),
            ),
          )

      ),

    );

  }


}

