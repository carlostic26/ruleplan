import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ruleparejas_project/provider/riverpod.dart';
import 'package:ruleparejas_project/screens/options.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonEnabled = ref.watch(buttonEnabled_rp);

    // Activa el botón después de 10 segundos
    Future.delayed(const Duration(seconds: 9), () {
      activarBoton(ref);
    });

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
                  onPressed: buttonEnabled
                      ? () async {
                          isLoaded(context);
                        }
                      : null, // Desactiva el botón si no está habilitado
                  style: ButtonStyle(
                    backgroundColor: buttonEnabled
                        ? MaterialStateProperty.all<Color>(Colors
                            .orange) // Color de fondo cuando está habilitado
                        : MaterialStateProperty.all<Color>(Colors
                            .grey), // Color de fondo cuando está deshabilitado
                  ),

                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 12,
                        color: buttonEnabled ? Colors.white : Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void activarBoton(ref) {
    ref.read(buttonEnabled_rp.notifier).state = true;
  }

  isLoaded(context) async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const optionsPlanesScreen()));
  }
}
