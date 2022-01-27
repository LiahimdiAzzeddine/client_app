import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart';

import 'dataget.dart';

void main() => runApp(MaterialApp(
  home: LoginApp(),
));


class LoginApp extends StatelessWidget{
  late List<GDPData> _Data;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late String udid;
  late String _device;


  final url ="http://192.168.1.6:8080/fluterdataUser";
  void postData() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _device = androidInfo.device;
    udid = await FlutterUdid.consistentUdid;
    try{
      final resp=await post(Uri.parse(url), headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            "nom": nameController.text,
            "email": emailController.text,
            "age":ageController.text,
            "udid":udid,
            "device":_device
          }));
      print(resp.body);

    }catch(err){
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: NetworkImage('https://www.utg.io/site_assets/images/slider/slider1.gif'),
                  fit: BoxFit.fill
              ),
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue,Colors.blueAccent],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('info',style: TextStyle(
                  fontSize: 50.0,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                ),
                Text('Ces information sont facultatives pour nous aider a vous connaître',style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Votre Email',

                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Votre Nom',

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Votre Age',

                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  onPressed: (){
                    postData();
                    _Statistique(context);
                  },
                  shape: StadiumBorder(),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text("Entrer",style: TextStyle(fontSize: 22.0),),
                  padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 80.0),
                  elevation: 0.0,

                )
              ],
            ),
          )
        ],
      ),
    );
  }
  void _Statistique(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return const Details(
      );
    });
    Navigator.of(context).push(route);
  }

}
