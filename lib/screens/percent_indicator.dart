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
  @override
  // ignore: must_call_super
  void initState() {
    //despues de 5 segundos se cambia de pantalla
    Future.delayed(const Duration(seconds: 7), () {
      isLoaded();
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
                    lineHeight: 15,
                    percent: 100 / 100,
                    animation: true,
                    animationDuration: 7500, //8.5 sec to load bar
                    leading: const Text(
                      "",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: const Text(
                      "",
                      style: TextStyle(
                          fontSize: 20, color: Colors.deepOrangeAccent),
                    ),
                    progressColor: Colors.amber,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Cargando ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                McCountingText(
                  begin: 0,
                  end: 6,
                  precision: 0,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  duration: Duration(
                      seconds:
                          7), //7 second to count numbers from 0 to n courses
                  curve: Curves.fastOutSlowIn,
                ),
                Text(" planes para elegir",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
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
