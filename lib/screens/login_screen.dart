import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isSessionSaved =
      false; // Variable para verificar si la sesión está guardada

  @override
  void initState() {
    super.initState();
    checkSavedSession(); // Verificar si hay una sesión guardada al iniciar la aplicación
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      // Si la sesión está guardada, redirige automáticamente al Dashboard
      Navigator.pushReplacementNamed(context, '/dash');
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    final txtPass = TextField(
      controller: txtConPass,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      obscureText: true,
    );

    final imgLogo = Container(
      width: 250,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://freepngimg.com/thumb/the_legend_of_zelda/21382-1-zelda-link-image.png'))),
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: () {
        // Guardar la sesión si el checkbox está marcado
        saveSession(isSessionSaved);

        Navigator.pushNamed(context, '/dash');
      },
    );

    final sessionCheckbox = Checkbox(
      value: isSessionSaved,
      onChanged: (value) {
        setState(() {
          isSessionSaved = value!;
        });
      },
    );

    final sessionCheckboxContainer = Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el checkbox
        children: [
          Text('Guardar sesión'),
          SizedBox(width: 10.0),
          sessionCheckbox,
        ],
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://i.pinimg.com/originals/0f/5b/c5/0f5bc560123be5bbf0a10a87c9c28537.jpg'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(71, 77, 205, 255),
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass,
                  ],
                ),
              ),
              imgLogo,
              sessionCheckboxContainer, // Contenedor con el checkbox para guardar sesión
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
