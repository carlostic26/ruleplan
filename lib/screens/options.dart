import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ruleparejas_project/screens/spinwheelscreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class optionsPlanesScreen extends StatefulWidget {
  const optionsPlanesScreen({super.key});

  @override
  State<optionsPlanesScreen> createState() => _optionsPlanesScreenState();
}

//Restaurantes: KFC, MC Donalds, Burguer King, etc...

class _optionsPlanesScreenState extends State<optionsPlanesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Color de fondo transparente
        elevation: 0, // Sin sombra
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showAppInfo(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 0.5,
              //img background

              child: CachedNetworkImage(
                imageUrl:
                    'https://blogger.googleusercontent.com/img/a/AVvXsEjZrZ4SvLJ-Jj3ZcWHDGbD0fH3DE2dDVGigDobzbj1F7ZrbHBFs9q1i4L1fPDXxt-olYwWxu4Gjp8wLIZGUKAqu-jRAKjUYqZk15RfNFCIUb1noT36rJwtqZs2QVLkoppMY32Nkc5BoetJGTJxJzjqqSbWQVtlbA9oK7PrJANF2vSXOernqiQ-fPA',
                height: 1000,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "RulePlan",
                  style: TextStyle(
                      fontSize: 70,
                      fontFamily: 'LobsterTwo',
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Comidas',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/a/AVvXsEiUq0HUTCQUICzDfKpcsABz7ZUZaZWas0WKL28OotBMZ9TFlVFyEHpLGu3_zMVFiUQZJOhDzjwlUYHpavuBQLurPEzXUF9-SChIdPLXVeaiKE3NljnjfJDcAQ7QFxK5bN8If5CGs2Y6LzuYo7wYoaVm5x_4zGjOiLimzUUB4QsUZtAvJHwK5lKWhQ",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Comidas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Bebidas',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieUc8WUp5XLWKHXBcXrooW_OCCSmyHJMu3QXzeMozA46tqgEsJ226qEnDNvStVOH4NsSPrbogfJZl614T-nb6sK5zaDadI5fnPU9RiWbnxCMVIzXYU86rNkHJh7BCpqj71wuCqWwlMXBcEjRXjOsbyYjs-N5mWymXDshNsW78ei_-TC2kSoTS7hw/s320/bebidas%20icon.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Bebidas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //2do renglon
              //Juegos de Mesa
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Juegos de Mesa',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8QXQJjFfYTSuIdJTaqQq3NS8cwNEylUDQboyohb__uAvxToKk9RYZz2x_UN8RZQkLtU5dxvAL2-hagGnUuuqiLefCAVk63tT4dR9RtGzQ3qgTRjG041itG_K3bfoi57S32AKDDvC8alipGlRBAq_H3wxsH3jwBVEt3ivVywiE7l7l7UaO16lUyQ/s320/plan%20juegos%20de%20mesa.png",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Juegos de Mesa",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Hobbies
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Hobbies',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjacTxTyarlUtroHrY5mBfPUFPQs2ht8OiCAhCCA0CWVwtcBDqIoiVUelq10UVStia2tXfY1oPjv0oPHIaYfdx-tJunso0HLih7Vb2pPb_cRUoniae7kW_hCvTMeJQWE2jZrmqutunBVh5jeizK4SyfAhsPqlKCTTI5I1wOZuOaxFL0F-_B_0UmcQ/s320/plan%20hobbie.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Hobbies",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //3er renglon
              //Juegos Outdoor
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Juegos Outdoor',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEic-Q3TOf_VkePRHd1D0Tfw4Y0nfl-FXK74WN8sXT-m7pDZ52OgwV2qHkFDE4wIn8xfQ4ZR_I2RSQ1PTVkDkT0YAczg_oX-Y7XNDTJUJ4J5RQbau4bcE0AUbWG3CPdJ90Lx-BSrLZO57tVzCc6WkK0HJHma59lAo9hEQjnlwM4JlE5AB-69QZVhiQ/s320/juegos%20outdoor.png",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Juegos Outdoor",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Postres
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Postres',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhd8EhMsQYCYg2sic_wnqOrAcJPCYSCpgHfHj9dS98drTXlW7oZqh4q4NKbIGbD2G33dDggiPHbkd0i4rdmc08RyNFrHrS4wgwoMT9Dh50xfLTZp18z2UpL3uwrPD7XqaKQw9x5la_Iem9xFvttF0BIBhVvvjAfSNZCDnz2Jt22GjMR3warGtM8vw/s320/icono%20postres.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Postres",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void shareApp() {
  Share.share(
      "¡RulePlan es una app para elegir aleatoriamente cualquier plan entre amigos!"
      "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.blogspot.ruleplan");
}

void showAppInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Información",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.pink,
                      ),
                    ),
                    child: const Text(
                      'Política de privacidad',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Silkscreen'),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      launch(
                          'https://ticnoticos.blogspot.com/2023/05/politica-de-privacidad-de-ruleplan.html');
                    }),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.pink,
                      ),
                    ),
                    child: const Text(
                      'Compartir app',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Silkscreen'),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      shareApp();
                    }),
                const SizedBox(
                  height: 30,
                ),
              ]),
        );
      });
}



/* PARA GAMICOLPANER SERVIRÁ SOLO LOS 6 CARDS ESTATICOS

class _optionsPlanesScreenState extends State<optionsPlanesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 0.5,
              child: Image.network(
                "https://blogger.googleusercontent.com/img/a/AVvXsEjZrZ4SvLJ-Jj3ZcWHDGbD0fH3DE2dDVGigDobzbj1F7ZrbHBFs9q1i4L1fPDXxt-olYwWxu4Gjp8wLIZGUKAqu-jRAKjUYqZk15RfNFCIUb1noT36rJwtqZs2QVLkoppMY32Nkc5BoetJGTJxJzjqqSbWQVtlbA9oK7PrJANF2vSXOernqiQ-fPA",
                height: 1000,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 1),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'comidas',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Comidas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'bebidas',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Bebidas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //2do renglon
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'Juegos de mesa',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Juegos de mesa",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'salidas_hobbies',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Salidas Hobbies",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //3er renglon
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 1, 20, 100),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'salida_juegos',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Salida a Juegos",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpinWheel(
                                        requiredPlan: 'postres',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/002/455/613/non_2x/homemade-salad-food-made-with-love-cooking-at-home-romantic-dinner-at-home-happy-couple-dating-time-flat-cartoon-illustration-isolated-on-white-background-vector.jpg",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Postres",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


*/