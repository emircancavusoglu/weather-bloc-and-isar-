import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/style/text_style.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';
import 'package:hive/hive.dart';
import '../../widget/text_field.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final GlobalKey<WeatherTextFieldState> weatherTextFieldKey = GlobalKey<WeatherTextFieldState>();
  late TextEditingController _controller;
  List<String> bottomNavItems = ["Cloudy", "Sunny", "Snowy"];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedItems();
  }

  void _loadSavedItems() async {
    var box = await Hive.openBox('textfieldbox');
    setState(() {
      bottomNavItems = box.values.cast<String>().toList();
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
              const SnackBar(content: Text("Hata!")),
            );
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state.weatherStatus == WeatherStatus.busy) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.weatherStatus == WeatherStatus.fetched) {
              return Center(
                child: buildColumn(state),
              );
            }
            return buildColumn(state);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('textfieldbox');
          String text = _controller.text;

          if (text.isNotEmpty) {
            await box.add(text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saved "$text" to Hive'),duration: Duration(seconds: 1),),
            );
            _loadSavedItems();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No text to save')),
            );
          }
        },
        child: const Text("Save"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems.map((item) {
          return BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: item,
          );
        }).toList(),
      ),
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
          Text(
            state.weatherModel?.location?.localtime.toString() ?? "",
            style: WeatherTextStyle.textStyle,
          ),
          const SizedBox(height: 100,),
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
                    child: Image.network(
                      state.weatherModel?.current?.condition?.icon ??
                          "https://www.google.com/imgres?q=rainy&imgurl=https%3A%2F%2Fcdn.girls.buzz%2Fimages%2Fgirls.buzz.max-1440x900.webp&imgrefurl=https%3A%2F%2Fgirls.buzz%2Fblogs%2Fon-a-rainy-day%2F&docid=V0TrtzfhoFgqSM&tbnid=aDT82BcHIlugsM&vet=12ahUKEwjJivb4ypSIAxU_SfEDHZqsC5UQM3oECHsQAA..i&w=1200&h=800&hcb=2&ved=2ahUKEwjJivb4ypSIAxU_SfEDHZqsC5UQM3oECHsQAA",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.weatherModel?.current?.tempC}°C",
                          style: WeatherTextStyle.textStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              '${state.weatherModel?.location?.name}, ',
                              style: WeatherTextStyle.textStyle,
                            ),
                            Expanded(
                              child: Text(
                                state.weatherModel?.location?.country.toString() ?? "",
                                style: WeatherTextStyle.textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (state.weatherModel?.current?.airQuality != null) ...[
                          Text(
                            "PM10: ${state.weatherModel!.current!.airQuality?.pm10}",
                            style: WeatherTextStyle.textStyle,
                          ),
                          Text(
                            "PM2.5: ${state.weatherModel!.current!.airQuality?.pm25}",
                            style: WeatherTextStyle.textStyle,
                          ),
                          Text(
                            "O3: ${state.weatherModel!.current!.airQuality?.o3}",
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
