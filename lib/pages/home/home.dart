import 'package:flutter/material.dart';
import 'package:projeto_tempo/api/api.dart';
import 'package:projeto_tempo/models/api_model.dart';
import 'package:projeto_tempo/pages/home/widgets/card_weather.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

final searcheController = TextEditingController();

ApiResponse? apiResponse;
bool isLoading = false;

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchLocation(),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildWeatherWidget()
            ],
          ),
        ),
      ),
    );
  }

  _buildSearchLocation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SearchBar(
        hintText: 'Search the location here',
        onSubmitted: (value) {
          _getWeatherData(value);
        },
        controller: searcheController,
        leading: const Icon(Icons.search),
      ),
    );
  }

  _buildWeatherWidget() {
    if (apiResponse == null) {
      return const Text('Search for the location to get weather data');
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 40,
                ),
                Text(
                  apiResponse?.location?.name ?? "",
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  apiResponse?.location?.country ?? "",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (apiResponse?.current?.tempC ?? 0.0).toString(),
                  style: const TextStyle(
                      fontSize: 45, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '°C',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  apiResponse?.current?.condition?.text ?? "",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Image.network(
                  'https:${apiResponse?.current?.condition?.icon}'
                      .replaceAll("64x64", "128x128")),
            ),
            const SizedBox(
              height: 50,
            ),
            carWeather(apiResponse!)
          ],
        ),
      );
    }
  }

  void _getWeatherData(String location) async {
    setState(() {
      isLoading = true;
    });

    try {
      apiResponse = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
