import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherState extends Equatable {
  final Icon icon;

  const WeatherState({required this.icon});

  @override
  List<Object> get props => [icon];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial() : super(icon: const Icon(Icons.add));
}

class WeatherLoadSuccess extends WeatherState {
  const WeatherLoadSuccess({required super.icon});
}
