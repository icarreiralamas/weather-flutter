import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/src/screens/main_screen.dart';
import 'package:weather/utils/utils.dart';

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MainScreen(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );

        return true;
      },
      child: Scaffold(
          backgroundColor: Color(0xff232634),
          body: Stack(children: [
            //GestureDetector(
            //    onTap: () {
            //      Navigator.pushAndRemoveUntil<dynamic>(
            //        context,
            //        MaterialPageRoute<dynamic>(
            //          builder: (BuildContext context) => MainScreen(),
            //        ),
            //        (route) =>
            //            false, //if you want to disable back feature set to false
            //      );
            //    },
            //    child: Container(
            //        margin: EdgeInsets.only(top: heigth * 0.03),
            //        child: Icon(
            //          Icons.arrow_back,
            //          color: Colors.white,
            //          size: 30,
            //        ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Utils.iconWeather(
                            weatherProvider
                                .currentCityWeather!.current.condition.code,
                            true),
                        Text(
                          weatherProvider
                              .currentCityWeather!.current.condition.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          maxLines: 2,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.5),
                          child: Column(
                            children: [
                              Text(
                                weatherProvider
                                    .currentCityWeather!.location.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                                maxLines: 3,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weatherProvider
                                            .currentCityWeather!.current.tempC
                                            .toString() +
                                        'º',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 40),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Previsión proximos 3 días',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        height: heigth * 0.2,
                        //color: Colors.white,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Utils.iconWeather(
                                    weatherProvider.prevCityWeatherModel[index]
                                        .day.condition.code,
                                    false)]),
                                SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Utils.diaSemana(weatherProvider
                                          .prevCityWeatherModel[index]
                                          .date
                                          .weekday),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: width * 0.2,
                                      maxWidth: width * 0.2),
                                  child: Text(
                                    '${weatherProvider.prevCityWeatherModel[index].day.condition.text}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                    '${weatherProvider.prevCityWeatherModel[index].day.maxtempC}º',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30)),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                    '${weatherProvider.prevCityWeatherModel[index].day.mintempC}º',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30)),
                              ],
                            ));
                          },
                          itemCount:
                              weatherProvider.prevCityWeatherModel.length,
                          //separatorBuilder: (BuildContext context, int index) => Divider(),
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Tiempo de hoy por horas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      width: double.infinity,
                      height: heigth * 0.4,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                Utils.hourConversor(
                                    '${weatherProvider.prevCityWeatherModel[0].hour[index].time}'),
                                style: TextStyle(color: Colors.white24),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Utils.iconWeather(
                                weatherProvider.prevCityWeatherModel[0]
                                    .hour[index].condition.code,
                                false),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              '${weatherProvider.prevCityWeatherModel[0].hour[index].tempC}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.wind,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    '${weatherProvider.prevCityWeatherModel[0].hour[index].windKph}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    'km/h',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.cloudRain,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '${weatherProvider.prevCityWeatherModel[0].hour[index].chanceOfRain}%',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.droplet,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '${weatherProvider.prevCityWeatherModel[0].hour[index].humidity}%',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                          ]);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherProvider
                            .prevCityWeatherModel[0].hour.length,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ])),
    );
  }
}
