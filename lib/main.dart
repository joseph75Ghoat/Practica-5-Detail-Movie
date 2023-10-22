import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/assets/stylesApp.dart';
import 'package:login/card_background.dart';
import 'package:login/provider/test_provider.dart';
import 'package:login/routes.dart';
import 'package:login/screens/preferencias_tema.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
@override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ChangeNotifierProvider(
            create: (context) => TestProvider(),
            child: MaterialApp(
              home: Home(),
              routes: getRouters(),
              theme: themeProvider.isDarkTheme
                  ? StylesApp.darkTheme(context)
                  : StylesApp.lightTheme(context),
            ),
          );
        },
      ),
    );
  }
}



class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final data = [
    CardBackgroundData(
      title: "Ferrari",
      subtittle:
          'La primera participación de Ferrari en la Fórmula 1 fue en el Gran Premio de Mónaco de 1950, con el Tipo 125 F1. Es el equipo activo más antiguo del campeonato, en 2020 alcanzó los 1000 Grandes Premios, y es el que ha conseguido más victorias (238), campeonatos de pilotos (15) y campeonatos de constructores (16).',
      image: NetworkImage(
          'https://live.planetf1.com/Content/Images/Teams/21455.png'),
      backgroundColor: Color.fromARGB(255, 201, 18, 18),
      titleColor: Color.fromARGB(255, 5, 5, 5), //Colors.pink,
      subtitleColor: Colors.white, //Color.fromARGB(209, 228, 77, 255),
      background: Lottie.asset("assets/animation_4.json"),
    ),
    CardBackgroundData(
      title: "Mercedes F1",
      subtittle:
          'Mercedes AMG Petronas Formula One Team, anteriormente conocida como Mercedes GP, es una escudería de Fórmula 1 dirigida por la empresa automovilística alemana Daimler AG. De ella han formado parte pilotos como Michael Schumacher o Lewis Hamilton. Inició sus andaduras en el Gran Circo en 1954, ganando su primer campeonato de Constructores con Juan Manuel Fangio como piloto.',
      image: NetworkImage(
          'https://live.planetf1.com/Content/Images/Teams/21456.png'),
      backgroundColor: Color.fromARGB(255, 0, 103, 110),
      titleColor: Color.fromARGB(255, 53, 35, 107), //Colors.purple,
      subtitleColor: Colors.white, //Color.fromARGB(255, 0, 0, 0),
      background: Lottie.asset("assets/animation_2.json"),
    ),
    CardBackgroundData(
      title: "Red bull",
      subtittle:
          'Red Bull Racing es un equipo privado de origen austríaco con sede en Milton Keynes, en Gran Bretaña. Es propiedad de la marca de bebidas homónima. El origen de Red Bull en el automovilismo se remonta al año 1987, cuando fue patrocinadora personal del piloto Gerhard Berger. Entre 1995 y 2004, patrocinó al equipo Sauber',
      image: NetworkImage(
          'https://live.planetf1.com/Content/Images/Teams/21457.png'),
      backgroundColor: Color.fromARGB(255, 24, 5, 80),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: Lottie.asset("assets/animation_3.json"),
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
          itemCount: data.length,
          colors: data.map((e) => e.backgroundColor).toList(),
          itemBuilder: (int index) {
            return CardBackground(data: data[index]);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.login),
          label: Text('Login'),
          onPressed: () {
            Navigator.pushNamed(context, '/dash_log');
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
