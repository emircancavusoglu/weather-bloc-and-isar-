import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../service/model/WeatherModel.dart';
import '../service/weather_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weatherPath = WeatherApi.weatherApi;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData()async{
    final response1 = await Dio().get(weatherPath);
    final response = await Dio().get(weatherPath);
    if(response.statusCode == 200){
      final weather = WeatherModel.fromJson(response1.data['current']);

    }
    if(response.statusCode == 200){
      final weather2 = WeatherModel.fromJson(response.data["location"]);
    }
  }
  List<WeatherModel>? _items;  // bu veri gelmeyebilir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Center(
            child: Text("Yerel Saat : 15:20")),
        backgroundColor: Colors.blue,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("LONDON"),
          Center(
              child: Icon(Icons.cloud, color: Colors.white,size: 80,),
          ),
          Text("15 degree"),
          Text("Party Cloud"),
          Text("Last updated at : 14:55")
        ],
      ),
    );
  }
}
