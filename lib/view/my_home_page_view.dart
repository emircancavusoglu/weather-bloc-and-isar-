import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../weather/bloc/weather_bloc.dart';
import '../weather/bloc/weather_event.dart';
import '../weather/bloc/weather_state.dart';
import '../widget/alert_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => const PermissionAlertDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadSuccess) {
                  return state.icon;
                } else if (state is WeatherInitial) {
                  return const Text("Loading...", style: TextStyle(fontSize: 24));
                } else {
                  return const Text("Unknown state", style: TextStyle(fontSize: 24));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<WeatherBloc>().add(WeatherLoaded());
        },
        child: const Icon(Icons.cloud),
      ),
    );
  }
}
