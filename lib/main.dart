import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ruleparejas_project/ads/ads.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/loading_screen_riverpod.dart';

AppOpenAd? openAd;
bool isAdLoaded = false;
RuleAdsIds ads = RuleAdsIds();

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: ads.openApp_adUnitId,
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

  //SystemChrome.setEnabledSystemUIOverlays([]); // Esconde la barra de estado

  await MobileAds.instance.initialize();
  await loadAd();

  TimerShowOrCancelAd();

  debugPaintSizeEnabled = false;
  runApp(const ProviderScope(child: MyApp()));
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
      home: const LoadingScreen(), //const SpinWheel(),
    );
  }
}

void TimerShowOrCancelAd() {
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
}
