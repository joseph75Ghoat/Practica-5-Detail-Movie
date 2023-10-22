import 'package:flutter/widgets.dart';
import 'package:login/screens/add_task.dart';
import 'package:login/screens/calendar_screen.dart';
import 'package:login/screens/carreraScreen.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/detail_movie_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/popular_screen.dart';
import 'package:login/screens/profesor_screen.dart';
import 'package:login/screens/provider_screen.dart';
import 'package:login/screens/screen_fav.dart';
import 'package:login/screens/task_scree.dart';

Map<String, WidgetBuilder> getRouters() {
  return {
    '/dash': (BuildContext context) => DashboardScreen(),
    '/dash_log': (BuildContext context) => LoginScreen(),
    '/task': (BuildContext context) => TaskScreen(),
    '/add': (BuildContext context) => AddTask(
          taskModel: null,
        ),
    '/popular': (BuildContext context) => PopularScreen(),
    //' '/detail': (BuildContext context) => DetailMovieScreen(),
    '/prov': (BuildContext context) => ProviderScreen(),
    'profesor': (BuildContext context) => ProfesorScreen(),
    'carrera': (BuildContext context) => CarreraScreen(),
    '/cal': (BuildContext context) => CalendarScreen(),
   '/fav': (BuildContext context) => FavoriteMoviesScreen(),
     
  };
}
