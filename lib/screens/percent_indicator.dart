import 'package:flutter/material.dart';
import 'package:ruleparejas_project/screens/options.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mccounting_text/mccounting_text.dart';

// ignore: camel_case_types
class percentIndicator extends StatefulWidget {
  @override
  _percentIndicatorState createState() => _percentIndicatorState();
}

// ignore: camel_case_types
class _percentIndicatorState extends State<percentIndicator> {
  bool _isFirstBuild = true;
  bool? contadorFinalizado = false;
  bool isButtonVisible =
      false; // Nuevo estado para controlar la visibilidad del botón
  bool _buttonEnabled = false;

  @override
  // ignore: must_call_super
  void initState() {
    //despues de 5 segundos se cambia de pantalla
    Future.delayed(const Duration(seconds: 9), () {
      _isFirstBuild =
          false; // Establecer en false después de la primera construcción

      setState(() {
        _buttonEnabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                height: 200,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Image.asset("assets/logo.png")),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 250.0,
                    lineHeight: 18,
                    percent: 100 / 100,
                    animation: true,
                    animationDuration: 7500, //8.5 sec to load bar
                    progressColor: Colors.amber,
                    center: const Text("Cargando ...",
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: TextButton(
                  onPressed: _buttonEnabled
                      ? () async {
                          isLoaded();
                        }
                      : null, // Desactiva el botón si no está habilitado
                  style: ButtonStyle(
                    backgroundColor: _buttonEnabled
                        ? MaterialStateProperty.all<Color>(Colors
                            .orange) // Color de fondo cuando está habilitado
                        : MaterialStateProperty.all<Color>(Colors
                            .grey), // Color de fondo cuando está deshabilitado
                  ),

                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 12,
                        color: _buttonEnabled ? Colors.white : Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  isLoaded() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const optionsPlanesScreen()));
  }
}
