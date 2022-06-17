import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Utils {
  static diaSemana(int numDay) {
    switch (numDay) {
      case 1:
        return 'Lun';
      case 2:
        return 'Mar';
      case 3:
        return 'Mie';
      case 4:
        return 'Jue';
      case 5:
        return 'Vie';
      case 6:
        return 'Sab';
      case 7:
        return 'Dom';
      default:
        return '';
    }
  }

  static iconWeather(int code, bool cabecera) {
    const double tamano = 60.0;
    const double tamanoList = 28.0;

    if (cabecera) {
      switch (code) {
        case 1000: //Soleado
          return const FaIcon(FontAwesomeIcons.sun,
              color: Colors.white, size: tamano);
        case 1003: //Sol y nubes
          return const FaIcon(FontAwesomeIcons.cloudSun,
              color: Colors.white, size: tamano);
        case 1006: // Nubes y claros
          return const FaIcon(FontAwesomeIcons.cloudSun,
              color: Colors.white, size: tamano);
        case 1009: // Nublado
          return const FaIcon(FontAwesomeIcons.cloud,
              color: Colors.white, size: tamano);
        case 1030: //Niebla
          return const Icon(Icons.foggy, color: Colors.white, size: tamano);
        case 1063: //Sol, nubes y sol
          return const FaIcon(FontAwesomeIcons.cloudSunRain,
              color: Colors.white, size: tamano);
        case 1066: //Sol, nubes y nieve
          return const FaIcon(FontAwesomeIcons.snowflake,
              color: Colors.white, size: tamano);
        case 1180:
        case 1183:
        case 1186:
        case 1189:
        case 1192:
        case 1195:
          return const FaIcon(FontAwesomeIcons.cloudRain,
              color: Colors.white, size: tamano);
        default:
          return const FaIcon(FontAwesomeIcons.cloud,
              color: Colors.white, size: tamano);
      }
    } else {
      switch (code) {
        case 1000: //Soleado
          return const FaIcon(FontAwesomeIcons.sun,
              color: Colors.white, size: tamanoList);
        case 1003: //Sol y nubes
          return const FaIcon(FontAwesomeIcons.cloudSun,
              color: Colors.white, size: tamanoList);
        case 1006: // Nubes y claros
          return const FaIcon(FontAwesomeIcons.cloudSun,
              color: Colors.white, size: tamanoList);
        case 1009: // Nublado
          return const FaIcon(FontAwesomeIcons.cloud,
              color: Colors.white, size: tamanoList);
        case 1030: //Niebla
          return const Icon(Icons.foggy, color: Colors.white, size: tamanoList);
        case 1063: //Sol, nubes y sol
          return const FaIcon(FontAwesomeIcons.cloudSunRain,
              color: Colors.white, size: tamanoList);
        case 1066: //Sol, nubes y nieve
          return const FaIcon(FontAwesomeIcons.snowflake,
              color: Colors.white, size: tamanoList);
        case 1180:
        case 1183:
        case 1186:
        case 1189:
        case 1192:
        case 1195:
          return Container(
            margin: EdgeInsets.only(left: 7),
            child: const FaIcon(
              FontAwesomeIcons.cloudRain,
              color: Colors.white,
              size: tamanoList,
            ),
          );
        default:
          return const FaIcon(FontAwesomeIcons.cloud,
              color: Colors.white, size: tamanoList);
      }
    }
  }

  static hourConversor(String date) {
    return date.substring(11);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    
    return await Geolocator.getCurrentPosition();
  }
}
