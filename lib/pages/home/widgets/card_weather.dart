import 'package:flutter/material.dart';
import 'package:projeto_tempo/models/api_model.dart';

Card carWeather(ApiResponse apiResponse) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            space(),
            Text(
              '${apiResponse.current?.humidity ?? 0.0}',
              style: styleData(35),
            ),
            const Text('Humidade'),
            space(),
            Text(
              '${apiResponse.current?.uv ?? 0.0}',
              style: styleData(35),
            ),
            const Text('UV'),
            space(),
            FittedBox(
              child: Text(
                '${apiResponse.location?.localtime?.split(" ").last ?? 0.0}',
                style: styleData(25),
              ),
            ),
            const Text('Hora Local'),
            space(),
          ],
        ),
        Column(
          children: [
            space(),
            Text(
              '${apiResponse.current?.windKph ?? 0.0}',
              style: styleData(35),
            ),
            const Text('Velocidade Ventos'),
            space(),
            Text(
              '${apiResponse.current?.precipMm ?? 0.0}',
              style: styleData(35),
            ),
            const Text('Precepitação'),
            space(),
            Text(
              '${apiResponse.location?.localtime?.split(" ").first ?? 0.0}',
              style: styleData(25),
            ),
            const Text('Data Local'),
            space(),
          ],
        ),
      ],
    ),
  );
}

SizedBox space() {
  return const SizedBox(
    height: 20,
  );
}

TextStyle styleData(double size) =>
    TextStyle(fontSize: size, fontWeight: FontWeight.w600);
