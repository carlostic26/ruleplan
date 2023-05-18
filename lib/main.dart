import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ruleparejas_project/screens/percent_indicator.dart';

//loading the only ad of all app
AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: // test:  // ca-app-pub-3940256099942544/3419835294 || real: ca-app-pub-4336409771912215/7574798105
          'ca-app-pub-4336409771912215/7574798105',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        print("ad is loaded ok");
        openAd = ad;
        openAd!.show();
      }, onAdFailedToLoad: (error) {
        print("ad dailed to load $error");
      }),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  // init ads
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await MobileAds.instance.initialize();
  await loadAd();
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
      home: percentIndicator(), //const SpinWheel(),
    );
  }
}
