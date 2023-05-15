import 'package:flutter/material.dart';
import 'package:ruleparejas_project/screens/spinwheelscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckBoxScreen extends StatefulWidget {
  const CheckBoxScreen({Key? key}) : super(key: key);

  @override
  State<CheckBoxScreen> createState() => _CheckBoxScreenState();
}

SharedPreferences? _prefs;

class _CheckBoxScreenState extends State<CheckBoxScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  List<int> selectedIndices = [];
  List<String> itemsPlan = [
    'Lugares de la ciudad',
    'Cenas',
    'Deportes',
    'Juegos',
    'Comidas Peculiares',
    'Romántico',
    'Fuera de la ciudad',
    'Plan amigos'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Tu código actual
          Positioned(
            bottom: 20,
            right: 20,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward,
                    size: 30, color: Colors.amber),
                onPressed: () {
                  //cierra pantalla actual
                  Navigator.of(context).pop();

                  //abre nueva pantalla
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SpinWheel(
                              requiredPlan: 'checkbox',
                            )),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        // abre dialogo explicando textualmente la funcion general de los intereses
                      },
                      backgroundColor: Colors.amber,
                      mini: true,
                      child: const Icon(
                        size: 15,
                        Icons.question_mark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                const Text(
                  'Elije tus intereses',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'LobsterTwo',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (int i = 0; i < itemsPlan.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedIndices.contains(i)) {
                                selectedIndices.remove(i);
                                _prefs?.remove("boton_$i");
                              } else {
                                selectedIndices.add(i);
                                _prefs?.setString("boton_$i", itemsPlan[i]);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndices.contains(i)
                                  ? Colors.amber
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                itemsPlan[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
