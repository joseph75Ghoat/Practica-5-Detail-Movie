import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/screens/preferencias_tema.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/screens/screen_fav.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos :)'),
      ),
      drawer: createDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/400'),
            ),
            accountName: Text('Joseph'),
            accountEmail: Text('Maldonadojose@gmail.com'),
          ),
          ListTile(
            leading: Image.asset('assets/fresa.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('furitApp'),
            subtitle: Text('Carrucel'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Movies'),
            onTap: () =>
                Navigator.pushNamed(context, '/popular'), //Popular Model
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
            onTap: () {
              Navigator.pushNamed(context, '/fav');
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Test Provider'),
            onTap: () => Navigator.pushNamed(context, '/prov'), //Popular Model
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Calendar'),
            onTap: () => Navigator.pushNamed(context, '/cal'),
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Carrera'),
            onTap: () => Navigator.pushNamed(context, '/carrera'),
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Carrera'),
            onTap: () => Navigator.pushNamed(context, '/carrera'),
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Profesor'),
            onTap: () => Navigator.pushNamed(context, '/profesor'),
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return DayNightSwitcher(
                isDarkModeEnabled: themeProvider.isDarkTheme,
                onStateChanged: (isDarkModeEnabled) {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }
}
