import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ruleparejas_project/screens/multitouch.dart';
import 'package:ruleparejas_project/screens/percent_indicator.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

AppOpenAd? openAd;
bool isAdLoaded = false;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: // test:  // ca-app-pub-3940256099942544/3419835294 || real: ca-app-pub-4336409771912215/7574798105
          'ca-app-pub-4336409771912215/7574798105',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            openAd = ad;
            openAd!.show();
          },
          onAdFailedToLoad: (error) {}),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  // init ads
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await MobileAds.instance.initialize();
  //await loadAd();
  Timer(const Duration(seconds: 9), () async {
    if (isAdLoaded == false) {
      openAd?.dispose();
      print("Anuncio de apertura cancelado después de 9 segundos.");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('adCancelado', true);
    } else {
      print("Anuncio de apertura mostrado correctamente.");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('adCancelado', false);
    }
  });
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RulePlan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiTouchScreen(), //const SpinWheel(),
    );
  }
}
