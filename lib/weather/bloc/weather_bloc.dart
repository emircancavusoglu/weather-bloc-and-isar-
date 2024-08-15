import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';
import 'package:lottie/lottie.dart';


enum WeatherIcons{
  Icon
}


class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  WeatherBloc():super(const WeatherState(icon: Icon(Icons.add))){
    on<WeatherLoaded>((event, emit){
      emit(const WeatherState(icon: Icon(Icons.sunny)));
    });
  }
}