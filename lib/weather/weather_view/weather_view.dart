import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/style/text_style.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';
import 'package:hive/hive.dart';
import '../../widget/text_field.dart';
import '../bloc/weather_event.dart';
import '../model/weather_hive_model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final GlobalKey<WeatherTextFieldState> weatherTextFieldKey = GlobalKey<WeatherTextFieldState>();
  late TextEditingController _controller;
  List<String> bottomNavItems = ["Cloudy", "Sunny", "Snowy"];
  List<double> temperatures = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedItems();
  }

  void _loadSavedItems() async {
    var box = await Hive.openBox<WeatherHiveModel>('weatherBox');
    setState(() {
      bottomNavItems = box.values.map((item) => item.location).toList();
      temperatures = box.values.map((item) => item.temperature).toList();
      if (bottomNavItems.length < 2) {
        bottomNavItems.addAll(["Default1", "Default2"]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.weatherStatus == WeatherStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Hata! Hava durumu bilgisi alınamadı. Lütfen tekrar deneyin.")),
            );
            _controller.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          } else if (state.weatherStatus == WeatherStatus.fetched) {
            if (state.weatherModel?.location?.name != null) {
              _loadSavedItems();
            }
          } else if (state.weatherStatus == WeatherStatus.selected) {
            if (state.weatherModel != null) {
              setState(() {});
            }
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state.weatherStatus == WeatherStatus.busy) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.weatherStatus == WeatherStatus.fetched || state.weatherStatus == WeatherStatus.selected) {
              return buildColumn(state);
            } else if (state.weatherStatus == WeatherStatus.error) {
              return buildErrorScreen();
            }
            return buildColumn(state);
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Hata! Yeni bir şehir arayın.", style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 20),
          WeatherTextField(
            key: weatherTextFieldKey,
            controller: _controller,
          ),
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) async {
        var box = await Hive.openBox<WeatherHiveModel>('weatherBox');
        var selectedItem = box.getAt(index);

        if (selectedItem != null) {
          context.read<WeatherBloc>().add(WeatherDataSelectedEvent(
            location: selectedItem.location,
            temperature: selectedItem.temperature,
          ));
        }
      },
      items: bottomNavItems.asMap().entries.map((entry) {
        int index = entry.key;
        String location = entry.value;
        double temperature = temperatures.length > index ? temperatures[index] : 0.0;

        return BottomNavigationBarItem(
          icon: GestureDetector(
            onLongPress: () async {
              var box = await Hive.openBox<WeatherHiveModel>('weatherBox');
              if(bottomNavItems.length >2){
                await box.deleteAt(index);

                setState(() {
                  bottomNavItems.removeAt(index);
                  temperatures.removeAt(index);
                });

              }
                          },
            child: const Icon(Icons.location_on, color: Colors.red),
          ),
          label: '$location - ${temperature.toStringAsFixed(1)}°C',
        );
      }).toList(),
    );
  }

  Container buildColumn(WeatherState state) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue,
            Colors.blue[900]!,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.weatherModel?.location?.localtime != null)
            Text(
              state.weatherModel!.location!.localtime.toString(),
              style: WeatherTextStyle.textStyle,
            ),
          const SizedBox(height: 100),
          WeatherTextField(
            key: weatherTextFieldKey,
            controller: _controller,
          ),
          if (state.weatherModel != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 140, left: 320),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: state.weatherModel?.current?.condition?.icon != null &&
                        state.weatherModel!.current!.condition!.icon!.isNotEmpty
                        ? Image.network(
                      state.weatherModel!.current!.condition!.icon!,
                      fit: BoxFit.cover,
                    )
                        : const SizedBox.shrink(),
                  ),
                ),
                // Weather information
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.weatherModel?.current?.tempC != null)
                          Text(
                            "${state.weatherModel!.current!.tempC}°C",
                            style: WeatherTextStyle.textStyle,
                          ),
                        Row(
                          children: [
                            if (state.weatherModel?.location?.name != null)
                              Text(
                                '${state.weatherModel!.location!.name}, ',
                                style: WeatherTextStyle.textStyle,
                              ),
                            if (state.weatherModel?.location?.country != null)
                              Expanded(
                                child: Text(
                                  state.weatherModel!.location!.country!,
                                  style: WeatherTextStyle.textStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                        if (state.weatherModel?.current?.airQuality != null) ...[
                          if (state.weatherModel!.current!.airQuality?.pm10 != null)
                            Text(
                              "PM10: ${state.weatherModel!.current!.airQuality!.pm10}",
                              style: WeatherTextStyle.textStyle,
                            ),
                          if (state.weatherModel!.current!.airQuality?.pm25 != null)
                            Text(
                              "PM2.5: ${state.weatherModel!.current!.airQuality!.pm25}",
                              style: WeatherTextStyle.textStyle,
                            ),
                          if (state.weatherModel!.current!.airQuality?.o3 != null)
                            Text(
                              "O3: ${state.weatherModel!.current!.airQuality!.o3}",
                              style: WeatherTextStyle.textStyle,
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
