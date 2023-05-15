import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:ruleparejas_project/screens/options.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'checkBox.dart';
import 'package:location/location.dart';

class SpinWheel extends StatefulWidget {
  final String requiredPlan;

  const SpinWheel({required this.requiredPlan, Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

SharedPreferences? _prefs;

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  String plan = '100';

  //deportes: Golf, Volleyball, Basketboll, Mini Fútboll

  List<String> itemsPlan = [];
  List<String> itemsRoulette = [];
  List<bool> _isSelected = [];

  @override
  void initState() {
    _isSelected = List.filled(8, false);
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });

    // TODO: implement initState
    super.initState();

    if (widget.requiredPlan.contains('Comidas')) {
      itemsPlan = [
        'Hot Dogs',
        'Spaguetti',
        'Sandwich',
        'Ensaladas',
        'Arepas',
        'Pollo frito',
        'Empanadas',
        'Hamburguesa',
        'Pollo asado',
        'Helado',
        'Churros',
        'Pizza'
      ];
    }

    if (widget.requiredPlan.contains('Hobbies')) {
      //debe ser un numero par para evitar formar doble franja del mismo color en la ruleta
      itemsPlan = [
        'Karaoke',
        'Caminata',
        'Cine',
        'Grabar un TikTok',
        'Picnic',
        'Paseo en bicicleta',
        'Natación',
        'Camping',
        'Escalada',
        'Senderismo',
        'Kayak',
        'Pintar',
      ];
    }

    if (widget.requiredPlan.contains('Juegos Outdoor')) {
      itemsPlan = [
        'Bolos',
        'Carritos chocones',
        'Montaña Rusa',
        'Paintball',
        'Volar cometa',
        'Ping pong',
        'Beach soccer',
        'frisbee o boomerang'
      ];
    }

    if (widget.requiredPlan.contains('Juegos de Mesa')) {
      //clue
      itemsPlan = [
        'Dominó',
        'Damas',
        'Ajedrez',
        'Parqués',
        'Monopoly',
        'Uno',
        'Rummy',
        'Póker',
        'Bingo',
        'Baraja española',
        'Trivial pursuit',
        'Risk',
        'Scrabble',
        'Jenga'
      ];
    }

    if (widget.requiredPlan.contains('Postres')) {
      itemsPlan = [
        'Natilla',
        'Pan',
        'Arroz con leche',
        'Tres leches',
        'Bocadillo',
        'Chocolate con queso',
        'Buñuelos',
        'Postre de leche',
        'Torta de Chocolate',
        'Helado de vainilla',
        'Pastel de zanahoria',
        'Crepes',
        'Fondue de Chocolate',
        'Pay de manzana',
        'Brownie',
        'Mousse de Chocolate',
        'Flan',
        'Wafles',
        'Quesillo',
        'Cupcakes'
      ];
    }

    if (widget.requiredPlan.contains('Bebidas')) {
      itemsPlan = [
        'Vino',
        'Frappé',
        'Granizado',
        'Juguito',
        'Agua',
        'Gaseosa Refresco',
        'Cerveza',
        'Cocktail',
        'Sangría',
        'Whiskey',
        'Tequila',
        'Ron',
        'Licor de café',
        //'Smoothie',
        'Leche'
      ];
    }
  }

  List<int> selectedIndices = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double drawer_width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),
      body: Column(children: [
        //flecha atras
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 5, 1),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30, color: Colors.amber),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const optionsPlanesScreen()),
                );
              },
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "RulePlan",
              style: TextStyle(
                  fontSize: 70, fontFamily: 'LobsterTwo', color: Colors.white),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.requiredPlan,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'LobsterTwo',
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  //establece el color del borde de la ruleta
                  border: Border.all(color: Colors.black, width: 5),
                  shape: BoxShape.circle,
                ),
                child: FortuneWheel(
                  styleStrategy: const UniformStyleStrategy(
                    borderColor: Colors.yellow,
                    color: Colors.yellow,
                    borderWidth: 4,
                  ),
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0; i < itemsPlan.length; i++) ...<FortuneItem>{
                      FortuneItem(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    i % 2 == 0 ? Colors.orange : Colors.yellow,
                              ),
                            ),
                            Center(
                              child: Text(
                                itemsPlan[i],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                  ],
                  onAnimationEnd: () {
                    setState(() {
                      plan = itemsPlan[selected.value];
                    });
                    showItemDialog(plan);
                    print(plan);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("El plan de hoy será $plan ¡Adelante!"),
                      ),

                      //dialog
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elije tus intereses',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'LobsterTwo',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: SizedBox(width: drawer_width * 0.40),
                    ),
                    GestureDetector(
                      onTap: () {
                        // aquí agrega el código que quieres ejecutar al tocar el botón
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpinWheel(
                                    requiredPlan: widget.requiredPlan,
                                  )),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 12,
                        child: Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 7,
                  children: [
                    for (int i = 0; i < itemsPlan.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndices.contains(i)) {
                              //agrega la pos del item a la lista
                              selectedIndices.add(i);
                              _prefs?.setString("boton_$i", itemsPlan[i]);
                            } else {
                              if (itemsPlan.length <= 2) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Debes tener al menos 2 items en este plan"),
                                  ),
                                );
                              } else {
                                selectedIndices.remove(i);
                                itemsPlan.remove(itemsPlan[i]);
                                _prefs?.remove("boton_$i");
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndices.contains(i)
                                ? Colors.grey
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${itemsPlan[i]} x',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  //gira la ruleta y cae en una franja a
                  selected.add(Fortune.randomInt(0, itemsPlan.length));
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: 120,
                child: const Center(
                  child: Text(
                    "Girar",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'LobsterTwo',
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void showItemDialog(String plan) {
    String imageUrl = '';
    if (itemsPlan.contains(plan)) {}

    switch (plan) {
      // ... Comidas ...............................................
      case "Hot Dogs":
        imageUrl =
            'https://www.gifcen.com/wp-content/uploads/2022/04/hot-dog-gif-6.gif';
        break;
      case "Ensaladas":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj69vWCnaXgE69W2Sg-tj_26DwtIvzRu4rQgw7zAIrxpBci3bgJUy9TxCQ413wKYsFzux1hXX8HfmHkn4b4LtRdDonrPBy2rpptcOKH7JWaCn3dO9AEoRNeZkdItEixFZiUap_3iuh6tl4Ft4lyFtf_w4iQSQ6DgEhawRkGckj8dWyim2yOUVHhmg/s1600/avocado-bacon-salad-lunch.gif';
        break;
      case "Pizza":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgD1icZ2qJwbmHHfooJ59pGS_IkmlynJa16bdOHclnsk0zOffCBU3Q8palt-pMwEoz5zh7eIJPQG46VXGm6tM1F8XGPQS0He8KB3K41YncknItMXCZriFIjAPpAiG5v0Fq74yU4Q5-WI-FWXUf2FVETo19CTto7-OGxK_SM-Vf-j1Femr5l7PK-rQ/s320/hellmo-pizza.gif';
        break;
      case "Arepas":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgpJYLxOh4IasccJ_aJuXDT2fdbjMY-BbfgTeszfAvhP7nThjMo5bZ1CTCThA26_gAm74G630L1GAgsdpTjOt_a3sNJaWIypgDhLfrIGwQjQBGOZLvaXZMH3NADK9KZmBNHT-EB-mTr2J5NQemptxZglUdStw30JqKUm-SQCT8mJvefbYybB-dnvw/s320/arepa.gif';
        break;
      case "Spaguetti":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQlx5hngDjt8JXVdRxYUCEdvOHi33lSMYS2KQrhuyGjdkwLEi0iMDMVPDvD5MxHZqE7Jc8csHyPcGHIPZMye9GJbmr6_7sTy_DiCd7kM_VP2ZM11NpZCfHSnTnh94FCA55SyHPq8hZCpiYFhM5I72Hmu-OrGEKNOtxJCPDlDEdeOFAWAmfvnAuHA/s320/spaghetti-cheese.gif';
        break;
      case "Sandwich":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuBsKra7DJb03-GAnfyJaLdOPA5wfE9IeezdHC2YuAx-F61TQoVcGCJc3tsZjAVsledirZTpoUEX8vYTbgS5OZkIeolBm5TSIvxNWgPaGlgQo8fCTOPDpduIBoPgZvPefeNhfquVrRu29pwhcWI1TeIZA6ycWSQUQQiWrcu-PNlCVW0tHat3fMVQ/s320/sandwich.gif';
        break;
      case "Pollo frito":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOPRGDy_j2D1eV3I7AV3fFRipB2vP5Ywx0fCsKBLWvpW_djX7b5iru0ENXdEDkfuqx2vMDp4joLAJdwy5atw8mcNYLasVwQ-WgQ9ynZz8iQjCEfm2Qn_JI4DcTDy1KRP9mINhFyWy_oRUF4HywMITiS1Ts5m33_B45CtrNbYxIotdLnyPir2yqVg/s1600/pollo%20frito.gif';
        break;
      case "Empanadas":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjA7TZ8LAjtI4ACVWvXjy3Wykkwos_6-rv3n_smOUcEH0wNtTmUgs80-5nb4mZddwVhMTd8qrop-KUHHjG5pQrLSyQEFdbfq6J4ezqqnzksG9-DJDWlkyhG4AZ8JGgJnCB73obVBmTuB0LHaLr7XgJO6K7v8AFCzg3JnYNfEEb2c8ewSDQi0RTwWg/s320/empanada-empanadas.gif';
        break;
      case "Hamburguesa":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiHR7YBx5sIGI4pMnKtjeT1aHYPsQhlMKDGm89bhWdLkXh4OIVe2UFuhMWPu1el8eSSNekcFxy2kG8Wgjnix3Hwk2CvoyofLU7F0jopaA6uR8TiNUlhiGMXuctDCDmeAXIWEJAHiHaIjKO4r48dYjQ8EdNROv4yfeo_HP1DaBT4weGrxoaPWqZjVw/s320/burguer.gif';
        break;
      case "Helado":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOjGoPhion0C7Rygb9_ENhNiBxoiCzniRPAO0WV1cMCqsLXLo3c3cQqTdrxfwMCg7YJfFg5PL-CxvMX9oA25RbuSEJQ4GCUbIQR3Bjjgl3nmPxnKMe4CXyEHAsHRPuIKNfvLJU8M2jG4ex-_uppathCfOzO6hSL9vApkYa2AosmPCzPlC-LArC3w/s320/helado.gif';
        break;
      case "Churros":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt4a71t8tTbk270SZrJQHSnlN0m79Km__fdxn9E8ly9sApy2_Uao_jgG2HkeEJGYtM8HkYVFVrU9NvnViDoXPJZqrxOUX6zErIwvvnyv46QOLCWGlhPuRn28uh-b69io_4HzDbjvt9UKN1EML5CZzqDEEn7Y0fk8WF70UfP7TdGizaXn9o9Ib_7w/s320/churro.gif';
        break;
      case "Pollo asado":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhtPLjFRgBi0icqd_k0X7EKf8e9DqHRaROC1zLBWDx-9R13MhRpNPD98suVKCs9-IclRJCzst9phUDXxA17te7aV_fuB0ZOk0Cavb9Pavvo5QnWT1nAHhL6joiEvkLxJEl4328HpzNbgNS9EodERbsY0WnaI2DppMdxACcpGLwmYe6jJNAdyMpFgg/s320/pollo%20asado.gif';
        break;

      // ... Bebidas ...............................................
      case "Vino":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEir9e3_A9-56Dg9Z2OnfeQYMX_e57UBLGf3RFSFo4XsbtFRxOTApQDuZ4qZ4ddlSaXvTZ06efch3SJNlZkO3V85lPxozGnbitbJkR-3Bzjt-M5Dc3d5XRE8H5t5PkP4aM2Pvqu1lMMmtV1CjyFxv1pn0ybBTJ2DseDvuyxkxfb8oSr4q1eq9QdWqQ';
        break;
      case "Frappé":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgiHEpCYHKIsv0icL6P8XG6VTaJC9j5wpLJzY5nRhrl8QpP72zjoCTOdSukZwqcZ6nahGSYMLLq54SHyZ-GYBfHkPQEgzF6C1vEA4jtOHCkIsy5ByXpLfqypo5_2_p1YQXbrOhF1dhvqC8NEnE9ggyZbdlhBBEqOKAXbbHcWin31holKi9137F5jA';
        break;
      case "Granizado":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjj6AXNCRcMcDbOLQb8nly6VU9eTVT_WmkcLR66L8ucd6UL_3dlZ_pKriu81GjThfzByNuTkZq-qYaZfc7x4wr5xc6XroQqLoGV-blq41q9AIDspeAjdvaKsw6dVtlk3zW35p-3rgSark1_pXnfx7KWLrlHi_y0uJq15qL0-kYVg4VGmMWdW3cESA';
        break;
      case "Juguito":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhSR_6pIkz-G_kQQhFLyqfwM-oidR8V9bsGDRjWGV8ylLm7DuAMK4Y-ytuKkFVaTYE0-eJQlVrf20_tKRHOi_wOwf93r_w4QMA9gCsD1nhmNnnA5cCdT2TrLg28aWhPZLEfI3XruYZYYR7fLWSpby8SMF7Ouw63eUOdC_UQqEOjyWw4yXOvi6ZI3g';
        break;
      case "Agua":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEj2t4ZKtb4M93psOgyeKGPAymFpE0f9X84NlC9AlIXMs9xHD4MssB9_JjZcFIDPw0ae1N8oGmoVkuIi93MKieXjzkWyAYaSYrOFvkboaNyducu8NOD8MZtchJHRqjrma-hUUzt2WR8cKj5xjln5bgEufWERSPm0_Dq388-ZMIDM_rGHbvHNRSA1tw';
        break;
      case "Gaseosa Refresco":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEh44fzSDDrTej3YAk_WNXMyuabw_GUNYw8BKmdTvmwAqrL4kGVmDmg2LO-suyTF2eU-_IoVpt2qCPz_rS3SjjClwml-7gG4Nz6tf2hncmRK14n4SUz7BdLUeE8gRkYlh-CWniDxswPfRWoRi0KOTwTR--ap742AKEJ6eAexdsw1_qKh0w9xCtlucw';
        break;
      case "Cerveza":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjB1aw0zdK_JiCBKWKXLyESDMkoK9qWkEQfkRML0KB3d67wQ5zzRXWwbG1xjZgRgaOi3cG9QXoXfZoSMkgACJ7EQtMYwL0PgfdZxLJwi0tP5iv1uGmiq4gZLKMb1v6Cc-E7GjORHTlddc0xQgp3-ZRFoigkTqdMgdyhDr7X5gXq1mNRw31ZUPaovg';
        break;
      case "Cocktail":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEggr6WWoVlhENAOvsK7Il5u0RQQXfBwub2lQg7LdR3U_YEV4N3AWY44U0arg8t_do17kLklfZZ4gnR_dGcfmuCoEhWm2aNIeTHJUsLWuKzeKELvOhCRNUk_L7N-mcTAVt7o_kjqlGu-wUfP6DfrM4M95L83j4Cv66Z3mgGjIDIDwLYXC8wYAcNXgg';
        break;
      case "Sangría":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEh2RDY14X4mw7wJXkzsGGJLkMHdWqHwJQjOkPAa2vR9lK9ebLubevM_e8Mwr_ycTsU6y4Xh_2va-JomqABL1_UacU-PZcGJ7-F6i3ijqFzOsc0wt-9_THLx-IfEqckPQyJFYk3i1dMPy6Nxz05xPQCpErxlMo8FBIADK5PN6A5F0sbP_0-KUckrYA';
        break;
      case "Whiskey":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhFhTZrftQxTl3gMi3bdwHQxHt103tAST7omLmZVcPoVVkWQ_qyES52vSzDs7e2Hqc7wLk6goAD6N6pGUz_3B_bLpZn62q_a4POgcg00jLNfoYPlX2wDiQvH_bKtPYC2BWMJwkXlpQqk2WacfU2euuZzGKCx_pz2Ns8dCWMC45sKFW9XLfDgZSiDA';
        break;
      case "Tequila":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhmB0a-2ONLT2xpgA5gbOXchD0rVPVCQgT0q5jE1XngIq3_ZmuyX7EXfSReHl94Bzyt56P2gYFx-TgNrghJHIglsudC7hZ2WvezX5qH1vHfhWHQRnR3ccv_HpRlaNoW1QtowYL5HtbwLMpOVRi1yX1cti_N7tM5R1Sg8cvwyVVz91pL__fuV0YhCw';
        break;
      case "Ron":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEg_Qkdx2gHsW0FON_VplVp7vF95lCp6PaidQ_f9jDQVn5j9srpYtSK7hF_xfAGGcXNzYYb5rN0BrCXh8MTuxsHwgGEkYqlToY4qOH6Xne_4KcoV-8FpG8YIdZcazM2X5VAzfXbVF8VYTJbqZaQIwgjL2e2Al52n-7JjMT5L5V9SoLH8U4C1qRdm8g';
        break;
      case "Licor de café":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgJDiZ25w53AV_UAF31AiIguizDw-IOu5njxXPEK2v2EqMXLxCeQDO14UvZ6uN9nEmrfV170O3e633heqo-0a7BHS4aBwQAdi70O6vMc1l5y8WunMgZy8iCQMtxAt5zeJ57wUD3r30Py4MdvawWsQcVe7LCJKvXX4qOGeJBcqNFOidjZCbxp0p0AQ';
        break;
      case "Leche":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhZ_sWbKoJWjlnS_YfA2F0AqxHcult-vDVs5uD5C1u_1z6Dk7lqC1-JbzLoTjsZVJYdrhoF4nG0yj6ew_bpJAHLdTJoHui_Qqm0NqUq6VcEiNzGFgI0Cdf0mgtCxMn5DYc3ZXBiUEJNhMyIfio1t5s_0fQ6_yUx4CvPkivs17Nc_jhXE413pgt0ug';
        break;

//Juegos de mesa ...............................................
      case 'Dominó':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgexlC7bjii-TYuKyuhCMbzOrKsEWauOltg85D3TNamwkwJ5P6E3jjuu1xfi3Wg21TrwcSL-Lcu4tUKB4R7yzabosLfGW4oCNMcltdqdWEwhAI9EqEVIyFNiMp_B_8FrVrdOJmoRQo2oz9zUMwcP__ZSFLLLyLd7mQiAH2U6Nibrj-VSwq7KRvDzw';
        break;
      case 'Damas':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhR_8aYXr8ze7rL9G0MV9WyOk9eyi8znCi7yXtpSbchvg2jubFfqDUIhkXK2-RgxS0-ahulusbqNjbV3Ol2ZAZE7a7n3yaqDJjTbGW6PxMV681UZmLQZFW7i7A9oZouTVDLBS6n0Df7j5o1lWzpUbTZgzqwxs_sUyASKFHRrihLe5BTWLJcj6kf3A';
        break;
      case 'Ajedrez':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgi-zKUNmsGJYxIoJXqeuqCQwgBWJyEzL7KcwWZ9iz5-TDdyT_eUbFoyHJwjLLvNVh2507lfnRYrvRZJN9M3V_PT-MSLHWJdMGle1ewxh2yvsDhWzQlEewsJlbvsgY3Z9rgBPWuTcA8WLMHvBFbjh5u-aJ-5gz7f5_Bo5MWMCCK6CwlJXlI_uUOIg';
        break;
      case 'Parqués':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEiSCC2Re0F5qnMkdeSU0kVAnjtHcItp0BzTidC8Zr6vI_zyh-krOwHMT2a41R_3XuBmVdWkbFoODWq0LGT37wsGAQOVy7alRxb57LLHzpBsAcNauMUqKelDEwVdc5ASuCbjp_Cro15DdvvGEodlgOXGI0fjeIAmgE63xD9ixbp3OMk2_bZhtZi2kw';
        break;
      case 'Monopoly':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgT4FGdLhyZ2TUPfJZL3H0DCDIYVdccvOoRb1gIYXVqkp6OtuzU4V1pPaj2uhypPf92_eXPp1nDd8uLFldkn7AUzwCWr-R9UOHOpte64B0lQO_enQcQgh5ZUKDmrOcjecExcrtFFTq0eVDfCyITgmC5OEkdUfFyJLLuqgek6OVWPWV60eO0kvZwMg';
        break;
      case 'Uno':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhAYqqEY7lYwCAUFLeiK0FVtm6qVmtcH3IbjvABeyUOiF7tIZD8f1MJxfjAARJfELQxNFtEwK8Hzc0lI2flbV3GL-IL0DBElEHWBoAxNJrqIWIvUXib9W7U8mRcmsLfIxGrr7RX3SiwFowrtMnD7TYOH4xvcIj2JiNsmANNdtXwQrLPeyXjwE5nGg';
        break;
      case 'Rummy':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEiuuB5jeItRjeFzID-8ick7atY_qGzBTA8CGRTZMjn6Z0pWIz0l_SpDOwbP5NJZO2hhWaoZ3iwGOcTMG2I1GA881KhifoaaM2ty3ZssPdtASR7c0638xtEcdeH5IP80WNEXQGzDFKg5mSzl8HuxpoHtEWLqq2u7fvnQ9jn6s7CKIfTgFxpURJtHAA';
        break;
      case 'Póker':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEiuuB5jeItRjeFzID-8ick7atY_qGzBTA8CGRTZMjn6Z0pWIz0l_SpDOwbP5NJZO2hhWaoZ3iwGOcTMG2I1GA881KhifoaaM2ty3ZssPdtASR7c0638xtEcdeH5IP80WNEXQGzDFKg5mSzl8HuxpoHtEWLqq2u7fvnQ9jn6s7CKIfTgFxpURJtHAA';
        break;
      case 'Bingo':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEj2MYZiOKXkTc2Q0J9c3XNfViYHZc_4GCzQfVPselAmFjOIenIWAn1Bkzo26Y6eM4lPZnzjFf_94DywB8RxhaL9AXjmQ7QKSN0pt5pSokBhl7h9C5OpPDjB3ES_gucZumdlX0wNQZlOm55c64ZQsnh3ipBIRWGXHzRA-yFxn5unc0YkOm4T_HMG8w';
        break;
      case 'Baraja española':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjTFQsxn31AQHxXl8K2zxNjM6kj8-PalFSaOw3nuGn6u6Dz7dln71jum9pu8JTkhG7EwkQWrI_nzbBULrd4aIfvwh2OgwZfpYsozESHezGZdbPFLf3PAzC7ojI_YTkFGn1ttTdIXQ4SbDnDAMCDWQ8T8VEasd_5RJcPntVLBJa9lVfdV8uekfS02Q';
        break;
      case 'Trivial pursuit':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgTIVDH0UQ6d_J2qfxWNOCkURPHpwsMPu_ZU9kn3tUP9lwOMOggwg73-n5WozoBeisbpj4LVmfgDea9Ks0IVcmRw5kVtrMUy2-i6PwCfEIvFIR_wotqeBapAsRVR5UmdftZqXDgJ-5tKmlLLAJsP3yUGcJ45-4ZLexHW-9k9T4g_0pxMYmZdAaSpg';
        break;
      case 'Risk':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgam6Wi-f9cjAeUafVNWiNHRjK7CNJVCIAb1UozhAiG-WRTKnj44zkMOJS9TR0B-JjeFzEf3739_9G5Ca7vbPfuWW_9LZ_CrvLYjddIkPi66WUcQ-as-EVvKim0ZQZiXltznwIxXWJaiBdYcn2NfecS-ZTe_hKp1AkmJQAFKd0u8uW6tPNQ-ljGtg';
        break;
      case 'Scrabble':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjphFRpJe1awiUVtQP22p6mbvl5U3WxbTvX6RA7WO-KUVo_jBx3fnBxjkvN6Ljkv7r2jzDkWFIEF1eq3ql8vtd4gn7iG7gtQpB3IXWWhNN0VT_lroZwiKn6WMx4ADRVKAPW4unkyeZXkr5kAccDZRfOgnt291vIxotD0n2s1YTHomKJ2PBl_7a4KA';
        break;
      case 'Jenga':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjn8XcYKtOZUVys_pP_CZEd2j5arRoEENkUtS6avlODDSml-XbPmM3L7vn85XmslDEuPHV3VMuJchcJbN87MEK5IfIBhc7nyKdFGLPzIY3pI88mDxEoyRjuWifJDQc8Ay2CHSaRAvLVxih5HLcLjSUEY4bjX0-DfIaMTRY2AHLqlL5HlS7pYSUtNg';
        break;

//Hobies ...............................................
      case 'Karaoke':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi2PW75NrBm_ydDxchbbvijVyO0upW6Y_G87VoS7qAxiSEgalVXIyipK2_JDUrXqOHD3bode7ZvPne2SeEwXAzT4GAZ6O4vtytI0QXU5F5GaFMrtBk4K-rMvJ2p1qV5-FtQMDfE8uUo6rfk2woqdOTvYhwLcT5QRDQJJ8bvMDzODiRPq-vPzvaPVg/s320/giphy.gif';
        break;
      case 'Caminata':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQpVZz6u0SlFUKQl_MvaN2MyBpAKkPcW027jU_O_q3Fy29S_x0cylvc9V-_M6353hDR8QmDwg6JOGeLz7_Irrh_h4kQqHHOhEyk43dUcWAxVAsE8DnEcy1h_v8JIi0hFQSe72SN8MOKeMy7kpD2lsmGaTeqZ7jKzgOfv-o7z5y7dTkWuOSmTDXGQ/s320/caminata-run.gif';
        break;
      case 'Cine':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4bOardHKQAnd8eyuUsZHZiBM-6dnxdEiLNq8YtaxvpfXNGiaw3ppSaJ1k38FzQ8gRyaGtjEmZwqQABAtTp3LDsOEcRYZM9aW9ixPbRN9e4OF3eIE_ZN5vgvkAg9T5OwEn1TKhKjJQDMSMDFuwEtIeT1P18LVwzR8xe5-ereyO0HB4V4WhL6POow/s320/9b2f740389f231e4d40fd4d16e7ced59.gif';
        break;
      case 'Grabar un TikTok':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYMawnGYalJaWBUArT44ReUEmMoO1u1HKhZQpNcO992DG0YhTNf9hC8-XXftE2DVB_3T_oqE-QL1YrqYGzxYcb16aHojOeNabDP3WfrX3kz2Ocq5vKSb22NnHXrC0Ps-qyFamG5b3MPicFRUKRaQDqu7kUWTSdHw7rf9qXG3fgFoyJapz2jDOF2w/s320/giphy%20(1).gif';
        break;
      case 'Picnic':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghpqFrXHOkiEA3H4mL3koxm6iWE-ITXndKRYOfYND2Ce727IzxDmXdin4dsh0Tx9UIVBo3rbxG72Ss0bJ2bY0ZoihIxHIK04YBtR-AxrI5LXvugowdIoyIfy8BseMBwcTRrpbFQcUuN4HkHTaSp3Waf68rU2AD2jrmg0--sBWJqBOgoAMHdE4tRA/s320/eating-picnic.gif';
        break;
      case 'Paseo en bicicleta':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj2DNHQA4I2ijDo0lRykyWyNKX7_gi0S26zQmExbHsXdlvStJDjwwePCZIcTfI9Bm2jaOESiZR8VGKgCaCrWAGZwMDDbkp44-DNsjeU7i52zHmcu3HFxfkRkmf0enUUZd776buL3-qpfg7SHWelNXwnAnVpFT2zzPVzrd8me_SNG817zOTN6cc0bA/s320/6392e83ad8c1f.gif';
        break;
      case 'Natación':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEin_MT0GOQDwIwYh9z3WkZKCPpQgoggBVDnxQ03Rsd5qWDzp3wWfj40Sl3At9hVW-z7K2Lg4XdW0JFt6fXXXfYeHEWyEsWHwe4uBfxwJUBcIMyXgZYOUNJGaUFiaL6n9vtQBAvIC3qt2310F0hiCBRAsO9dT60IMC63CIbX6qI2exgjkWarrJQBaw/s1600/Q2lQrR.gif';
        break;
      case 'Camping':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiK_WfVSyKqayTYQiK1t4EF30DMZ4kgRSmD8NK5XT5NOiZfdeGEizGD9Z__84NXu4n540Un6j8YhczRbWEjned4LOOgfQVnQgynSaotzGd73KFbbmlmC0W6q2ToaazaOn3TdyoxC3i_gGsXIXebXTonrGijgjmQmcJQE2nm5QH-5Sw38FtVkY2tew/s320/giphy%20(2).gif';
        break;
      case 'Escalada':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhLOwfDenepWHDz_WKns0Pq_M1BJPSJEqEC3zsZ1MWp7KTDt9D34u_iv8Q_zjXYfivgYhAWrZ_N10Dav_DbX0OE_FMOikE_uwy3TIlaGJX3ChUBi14iGWOHbfD3x8MeLQdXPknJUVmxNiplAFXbBkyem8IlL1SFnFQtsZEw_ymToXP6mBRMa_EehQ/s1600/lol-funny.gif';
        break;
      case 'Senderismo':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibe7KfZwBWiCnsHSpUDfHgx2JE0231KCgw3b7rzloSc_gvdjfS7BD6utCL4g4JMSX-7N9RAJQP0pErMzJ9CvwtPISPhq7u5WwW7wD4dg8b0_ueUcGgwWJXo8gCy8vCJ8nmm58mvFWBpcHJi4Hs9-JgDwukAAkkTxLDIqWzCtZnmqkXg7DNbxK59w/s320/giphy%20(3).gif';
        break;
      case 'Kayak':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh4R-SzIB1QU4yWWBz8lLGO4zIaeUcNLvEe4V364TUbF7_-OKYmqIOaLWcceEisKUJqRuHiFaYtp8xr9gHWuY8ciFhxpJi3p0_oz-wW3BbKkHWHTVK6nsl0HmvBPV1OMBu-j2wAqXchlxaCIiUtmJMpFAXGq7qS_u1JkAdZlo0W9BFxlJiVERiISA/s1600/giphy%20(4).gif';
        break;
      case 'Pintar':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEirKKPefpET0vR5aBah7QrZDiWvpRNRozX3saBvNSVi-8dIFKNcdTgvQCrkQkuGKAxSac1Nk8bMYDD4YHbpXm2a8UEMqqOAmrSlVNNwOYscWLZpzpOXoPc-RgMIvh7KqE0AC34Xo8ccAVinHsQEZ1eTdxQ3O2ta6zZvZbff6pbGMMGNfFZdobrmbg/s320/pintar-pait.gif';
        break;

//Juegos Outdoor

      case 'Bolos':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgWWXS0I73zUZ6BX5u99FeQpkTU6PCE_r2Sr2AppLeT8WeUv3lL3Jt7EsZ_sr4iO4PWmpug51d14LdSqTxRwW1OmM9lxS0-f7jejIdIrtxJcwnICJhJ4e72aHkTXY6vmjI2m63NgyWp5R8vv_-3gidEPzGu7nTgo_0lv4nUEQAw1YgHCy2oj3xP7w/s320/giphy%20(5).gif';
        break;
      case 'Carritos chocones':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMWZVHioTW5dYNt2X2pdffGY5Iv6Hsh-rgu4ZU4zXtjuWiJyRx4mroXwEOhHQecAbpmM-Bd5ySg0n5Ksk_iodOMIpdf_I4xq6DdbRLuc09edBAhiHJqFUieDVMgAM45gVs5LAZXDzyL4Ga5I9P2nYGoVAZMzcItIUwjesJcknzPKNqdyYZ9rjB_w/s320/tumblr_mwc39gd6O21rjlxg7o1_500.gif';
        break;
      case 'Montaña Rusa':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt9K3vX5BAkD-D5Qr7_et4VMtAZQlYy631lTemlKGASoxQ1t-c0R5PNOB8AOob8PV-Z7Iwl6Ppu2FXNxI53scHXjRnv43RUkRMWUGaXOBuVx9w6uTeQYQgabLbpftKzAfxQ-NMgR5MULEeIDd-DLVzojsRycAc1BXeluqkAjEKBdik9_kPnsNZ9A/s320/BestVigorousApisdorsatalaboriosa-size_restricted.gif';
        break;
      case 'Paintball':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBlctGY7HPDbtFpm6zZwaTmqhs_VqB1f87QJlLQSZMv6-dZ0H-pC12rfMggiF1aCKoEz6PWWbQQvc4BMXrscGfU0u6R0SgRtN639rG2DgUrw4e1X_EM0Iuvdh7RUEqMGODg2G9aI0il8_E10hNzaGVABNxO4UsNKJixxu77T73mxt74a5JEgq5Pg/s320/AdmiredAchingBuzzard-size_restricted.gif';
        break;
      case 'Volar cometa':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg4Ykde_LdioUg1z2gpvFJVJqO6_3arotR7pFqjVAp09MrstlGW2pDbLbGxIQpW137pN7jOlJW7XGpC3_n2UInZLHk8K7qCA18zbUTWGnwXsOehdX9i6GqH9LrlchLj5beomasETow7hxO7wIIk-0RGcZX2tlOt-sbV32tIf2flxcCenjQfg-q-vQ/s320/giphy%20(6).gif';
        break;
      case 'Ping pong':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEil7f81jiZJybJtZeKLF4HNQnQlT5IRecxqrpu6WF_w4r1vhGmh5Dqhub1ndLA0WRGm_MB6RTbi0Ji2jv-u3r5fKQPqmtMuhd_v4AKZ7c9zfq5m_UyfDa7TpDuNibMLugMZ7N79UtHH2ED3-3ft-j70DID4gjUnT9R_Kxj-EDF5cCA9jpNcgkEqJg/s320/ping-pong-chaves.gif';
        break;
      case 'Beach soccer':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhRszK69txE-jI8EMYh59WjE8Q4i21WH5t36X5qn3XX5rFzCTE9CbutUlrswUlxsfKWVEgwdPVRxvfGiXDTggLaF2iYGkl0sq_WyxJpsJcXqUYooT0x5gqp6tleQJf9bGQU8362oVewsQUjdzHOPRE1PE11tY8hLKrtJo-KyfHiIG0jH-1rM2qE-Q/s320/tumblr_lw6n5qOfDs1qetw96o1_500.gif';
        break;
      case 'frisbee o boomerang':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh__JCOEhX-qGsZEI4tNrsMZVp-MBeJm8_HD_uFf0AMyMmGOktfR1m-9hpCKwuSVOvgpX3gIvYnl2ADXnFIBuk5P5lbPnt_wftEzSEvWVXKbrCIWTAs6AFTaTN-kWwK9jevEfvXlLsBxS5g8naJOMoCcTTRvGhsKFqVvf-ZSnKfixVg3MS7tnR3Og/s320/SourRepentantBoar-size_restricted.gif';
        break;

      //Postres
      case 'Pan':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjzqg0McZjPMUNMBDxqh8nDnAMAiqYnyiKAPtEMWsbE4dr9TQc32OaRJDN6R4MwLrqEMdvr9HntRlLDCNwv15aj4HsCFLBdPaKxmXn-YpuImD8adZj-iNO-qkmK0s6H8MhVeWeqvJw0VD1OxQD65-ij2_LRk4kx7Rm3GnuupzwlQYtAI8flvTVBQQ';
        break;

      case 'Natilla':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjE1O7wBzCFpsF0fUUsYbJ5qOmw1RsxexTewXG5VwHkJ_lRTpyYKFahKFr6yNwf4kDbfuSsjKFksBpgz5m3U_vtrcX4b2IdfL6zE0UX39s2b_H9NeZVVuAPN8UBoufKkwYAjs-CMapPcMl05kTcrcXbLLyoHb1ksttDB0xMEl6nCAM6hkh59CFXUg/s320/natillas_caseras_47768_orig.jpg';
        break;
      case 'Arroz con leche':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgIY724EqbEGklBnYouEAjw6ey_iplivtWiIHyROzzwryZlLsZe-K6KGsMuh088YUx9yZ0gWbPPceJF8rR688wZEEyhWvZQ937qOtvNBpF8C2MDHjH7ou95ypbRGWLoHx3QHczw86M1MpK3XRPZwBL7p_oFxkQo2iLjehMNDNbP_vCNlkm8wrVrhg/s1600/e2cb2c9a7b5744edd4131e1b307fa1a6--slow-cooker-desserts-cooker-recipes.jpg';
        break;
      case 'Tres leches':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEilhtN4iEt8kx69Ej01TFMn1rzDewkHTYtzDatJq7GmbWGNUEyNvGmdc7L3WgzupTZEaTTlsd_3zk0JTZZxduycsqcYuNnxtUWdBmbf1vyfGwdY4VcQtCQE6heXpCvrc7OKYumBFqc9TSxInA-5O7N4-ddWsFCjttQJDlHMYW3Ct5wWD6v5KsaUQA/s320/photo.jpg';
        break;
      case 'Bocadillo':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgj5RyIceqkD_hSSVcyp2CZMKIttll_OgNnNjCBSTm_QrHP6mZpi6JzVmBE1lr5VRh4w3iyxz8ZMFC0YSziGzE5WWmrFIh9aX2DNVcoVhjwdnoSKbYxPLqiQWA5ckS0NVi_fNbsfJBBZ1jWADlXQGHsszREFrvnAKnHv8T0O8PV1BIgs3KKj-cp6Q/s1600/descargar.jpg';
        break;
      case 'Chocolate con queso':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEji99tR1nPAUI5V_Hm4T4b6W_N9u8QIPe_2LimXgLWB_6NzJbj7NTZhDibYnko3Cg9wjAEtnV7EnWBqb4r7ClO9iELwjP262CQBh_-I_iPUBzbMQWd2IxeDxARDNYMEuinpsfJHFYairmsOLhmK7zfbSH9iR5TWme3QwvbT1K302PhOjdst9tfFuQ/s320/117610125_10157224008001691_1650652298194065723_n.jpg';
        break;
      case 'Buñuelos':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiilex-En3pPh6bgWMuXPUpPXu70m0tXrkZlEByYe4zlHcMTpFL7koCazODTaHbeOi-ysblhueSWcUuuUVG-GT9ek4JpN6PS6Y4VR5xoqoiLctiKu_KvNdwyEW_3U38MExJQD3uDY_S7SHbX8HsuMiyw60ValMIHt3fCVxgKUDpmVRoyvQZ-kduzg/s1600/images.jpg';
        break;
      case 'Postre de leche':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNOjaYpazLaf9u85b4eoLeXN8eFQS7_N3gHmFWjt0I7xlz3QcXhCgHAYhdZPPhUsOpAX4eIJiJv1F9dEoj5pxOC2oAGP1MQcTrlDX3q_684QCGDlcJNaas2aDi7NHqAXgaQTerKeSaKDWWCfTsUwTmkpB0UycSKWevLaoC_NsXl3xqKRFowZZh0w/s320/3e88ce3dea00d09bd1c45f52637c698f.jpg';
        break;
      case 'Torta de Chocolate':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVIp0UHW3ZRUWqrnzx6uNmkM4kF05TeI2-xoXPIP15sJljH2M7BDI5QHZBgIlO2aykdk1rIIdx5T0h1MTuBypfY3bt_ehvIcnPpMiBdmtrn0cr-1sUz_kaAES787FJFfOIc6idqF4pHKUirSTGBboLIw-guPSKtKrBLFPIxQRtBj6vqFwQbktMfw/s320/DOR6EZSL5BHAHBAXSE4AJ3LTBM.jpg';
        break;
      case 'Helado de vainilla':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgdaaeb6r46gxsTjTeQJBJoNDhmCLmsdS4PfeqPJ2vuXWj5XK5oGS3_SFkczI5z88Gc-eqBu-mzTvB1YAQ3EgIF-JdTcx3LNbHdDRPLdSamPq7iTDinqBFcrGJ0PIgKURWE50rEEU-no-78U1BtEKC_akPI83S7ZTyfLMSuXrB2vqPRTrBz9XQFAQ/s320/Helado_Vainilla-web-553x458.jpg';
        break;
      case 'Pastel de zanahoria':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCXLy1BJNCkgbyvjHfIL84qjIaod9Qpiu3zEX79E7jiMWrh43u3lcuvzrElN8I22jCNUI60dJpFz5wupjfWhrsU4QYZlraIfl0-zD0vmwiKLfAEzUH0IU32ORTvglZRPRRD6-6Qli43s8BqQYfBBzNN9hlOHq0VGFDZ1MWQgmiOQKuiLTNkn2alw/s320/Receta-de-Torta-de-Zanahoria.jpg';
        break;
      case 'Crepes':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-GNVcIOCPYkL8Lg55F2OIFvx-jzPngFedM34zc9Q2q9hs2sNKWlzqU2Kmhq142uTHdtScKclQj7I4ijeeXHIfeeTf-6PdTAVgBigeF3t-mlHUP65oHHiKNAbIQ7Ra9cqxFoMs7Vsaa7ZkByAFGhaDXhMuJ9qFApTHVmRQsxPkdEs1HhfNLCmLOQ/s320/como_hacer_crepes_dulces_50644_600_square.jpg';
        break;
      case 'Fondue de Chocolate':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVgs_tVZR-PCFCEQPvXto3gPPxfpSmNncA9P0yiTVhRdGJLxHTZkLPpvG4k-bAssquseV75TmCHbrn4g3CL7Kiw-Wj_IiKqAbmzjLWWC-KAUYmOABJmdqrU8YkCnzOjSwIhlDw_3gMZji-lNm2zy9ftX8z51FvEMTKxvMY3kL8CslRDXkKk8Mx1Q/s320/Simply-Recipes-Chocolate-Fondue-Recipe-Lead-Shot-5c-1a6f22ccef754caabd5009541b4b132d.jpg';
        break;
      case 'Pay de manzana':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiiA_-4Nfo9_8IA9KMiZFqGIIQPDUMfsckUp-oc4-QZfW9v1zHWiKqOVxxlbzp2zjUGUS9naWHyj8kjjaIKtYpyNLR4p6-ycqTsG1kNRj8t-VdW2ekvvSIe4Xk3ygZCupY6KG2ql4WVFXf_klmd3-sB256YSsJe3uiGW1xJEaC1s8KSCC1VJejwJg/s320/81.-Pie-de-manzana.png';
        break;
      case 'Brownie':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEixSva4AFEppBle4e4dYUoG20vw0_DtvVAlbKwxvL_u4O4bOOU5AXmivaXgnYlMycb79wP-jRAp3CT76pTss1t_ZGDgVKj_W4TygP0S8ZzyDPBcMCtVB_fA5h0Yq6T618y4GjsZFmo1QzPrltANrcGTo2QDzmD_9N0Hwo0aMYh3iRh8nrvwVNTkTQ/s320/brownie-de-chocolate.jpg';
        break;
      case 'Mousse de Chocolate':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVgs_tVZR-PCFCEQPvXto3gPPxfpSmNncA9P0yiTVhRdGJLxHTZkLPpvG4k-bAssquseV75TmCHbrn4g3CL7Kiw-Wj_IiKqAbmzjLWWC-KAUYmOABJmdqrU8YkCnzOjSwIhlDw_3gMZji-lNm2zy9ftX8z51FvEMTKxvMY3kL8CslRDXkKk8Mx1Q/s320/Simply-Recipes-Chocolate-Fondue-Recipe-Lead-Shot-5c-1a6f22ccef754caabd5009541b4b132d.jpg';
        break;
      case 'Flan':
        imageUrl =
            'hhttps://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgb335O2Gw6Ec-MLUFx9JohMTIrId57U5TG1nJZiTU4E0wK1PFmgevw6a9Su4_6ka4OyO9Edop4gRrQn9HvVdEDGySNgU1fCJtrY_7_ewh2DBzVnrieE5aZjVFuN_y7Yr0GS6cvc0_HlirVRb-FTo_x3-x6_H8i63rK4j7BGqWbkMJqk5j6bJdTyA/s320/Creamy-Caramel-Flan_EXPS_FT20_2197_F_0723_1.jpg';
        break;
      case 'Wafles':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh_MXlb5M9NrGmmAKnRtPjg6h3f8tQMjs9KQZdAJmUpsC13FOPbYc-5ShcuGdvc9sU07QCOz25YVSxyykoS9j5BMBKrd9Bd1Gx2GVsODaq-1_ghUOauKQ5hDvj6e_7FK8xVakPDu2wHTiHnomYQS_I-EmqRLyaJdtnzzKoOIQRC4lGNMdnwCBk_fw/s320/f9f12c9d8d0e8028c1b6f8a3f76d0d65.jpg';
        break;
      case 'Quesillo':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5PGaSRW7mX-N0J-Xw_tpyljNf8Xuyvlu4OCjOuRISZQtzIMQHGvnKd6GC4CFEuqUDtiJzkiNssafyZpvnJivcpHMnW62zsiGhGJKPbOzpUVZDP-LgwzCWoG0WgaTa8riMES-7UMmnaqf4_ma--rrAg8h8Ml6N9mBldZFODW_ru5KofeDrPLTMmw/s320/DSC_0125web.jpg';
        break;
      case 'Cupcakes':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCxWy6Qye1E_lYOtxTdZGHUSZq7A-Dc8359Dx7DWKCnR2jDZ_heiG8AdzGQ2IYneXaSdFy2xEJWd5svxl3Irc2XH4z-nS1VRPFbR_HYx36p3lvzbz3U36rFWx_3zADOqSgaVRQmrfuamPhsLHNV1wRR3t1iH9uiWZNAgwadqz1z8pI764t-X-Ukw/s320/cupcakes-vainilla-decorados-merengue.jpg';
        break;

      default:
        // Si no se cumple ninguno de los casos anteriores, establece imageUrl en null o en una imagen de error.
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhIv6Qc9spnhIJoNeei2DPvu3KF7ChsTQmftKJgVEBzO51AsoadUym-Znd0ZP7aJ5Yj_-oKfUJ5a0V2I3MX0lHI6AFG0N-35JYja6zX88x4ghy6AyA-kaqoy-TDBsu5AO0vfozASP3wpxPnYJboAeIyWIqTbWPaFZkR6BuO-byFMUZElfGY44OBTQ';
        break;
    }

/*
        'Natilla',
        'Arroz con leche',
        'Tres leches',
        'Bocadillo',
        'Chocolate con queso',
        'Buñuelos',
        'Postre de leche',
        'Torta de Chocolate',
        'Helado de vainilla',
        'Pastel de zanahoria',
        'Crepes',
        'Fondue de Chocolate',
        'Pay de manzana',
        'Brownie',
        'Mousse de Chocolate',
        'Flan',
        'Quesillo',
        'Cupcakes'

*/

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 1000,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(
                '¡$plan!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              description: const Text(
                'Abre el mapa para ver los sitios mas cercanos e interesantes para este plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              buttonCancelText: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkText: const Text(
                'Ver Mapa',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: const Color.fromARGB(255, 188, 19, 64),
              onOkButtonPressed: () async {
                _requestPermission();

                // Acciones al presionar el boton OK

                Navigator.pop(context);
                final url =
                    'https://www.google.com/maps/search/?api=1&query=$plan';
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launch(uri.toString(),
                      forceWebView:
                          false); // Para Android, usa el navegador predeterminado);
                } else {
                  launch(url);
                  throw 'Could not launch $url';
                }
              },
              onCancelButtonPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }

  Future<void> _requestPermission() async {
    final location = Location();

    final permissionStatus = await location.requestPermission();
    if (permissionStatus != PermissionStatus.granted) {
      // Permiso no concedido, maneja el error.
      return;
    }

    // Permiso concedido, continúa con la lógica de la ubicación.
  }
}
