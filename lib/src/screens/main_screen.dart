import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/utils/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MainScreen extends StatefulWidget {
  
  const MainScreen({super.key});
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _text = TextEditingController();
  bool _validate = false;
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cargando;
    _text.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      Container(
        color: const Color(0xff232634),
      ),
      SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text(
              'DNDB Weather',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.5,
                height: heigth * 0.35,
                child: SvgPicture.asset('assets/svg/image1.svg'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                SizedBox(
                  width: width * 0.4,
                  child: TextField(
                      controller: _text,
                      onSubmitted: (value) {
                        setState(() {
                          _text.value.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          _cargando = true;
                        });

                        if (!_validate) {
                          weatherProvider
                              .getCurrentCityWeather(value)
                              .then((valor) {
                            weatherProvider.getPrevisionCityWeather(value);
                            Future.delayed(Duration(milliseconds: 800), (() {
                              Navigator.pushNamed(context, 'city');
                            }));
                          }).catchError((error) {
                            const snackBar = SnackBar(
                              content: Text(
                                  "La ciudad que ha introducido no es válida"),
                              duration: Duration(seconds: 2), //default is 4s
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Introduzca una ciudad',
                        labelStyle: const TextStyle(color: Colors.white12),
                        errorText:
                            _validate ? 'La ciudad no puede estar vacía' : null,
                      )),
                ),
                SizedBox(
                  height: heigth * 0.1,
                ),
                FloatingActionButton(
                  elevation: 4,
                  onPressed: () {
                    setState(() {
                      _cargando = true;
                    });

                    //weatherProvider.getCurrentCityWeather(query);
                    Future<Position> position = Utils.determinePosition();

                    position.then((pos) {
                      double latitude = pos.latitude;
                      double longitude = pos.longitude;

                      String positionString = '$latitude, $longitude';

                      weatherProvider.getCurrentCityWeather(positionString);
                      weatherProvider.getPrevisionCityWeather(positionString);
                      Future.delayed(const Duration(milliseconds: 800), (() {
                        Navigator.pushNamed(context, 'city');
                      }));
                    }).catchError((error) {
                      const snackBar = SnackBar(
                        content: Text("Active la ubicación de su dispositivo"),
                        duration: Duration(seconds: 2), //default is 4s
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  backgroundColor: Color.fromARGB(255, 42, 46, 63),
                  child: const Icon(Icons.location_history_outlined),
                ),
                if (_cargando)
                  Container(
                      margin: EdgeInsets.only(top: heigth * 0.05),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Localizando ...'),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ))
              ],
            ),
          ),
        ]),
      ),
    ]));
  }
}
