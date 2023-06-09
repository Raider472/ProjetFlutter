import 'package:flutter/material.dart';
import "TheAmazingRow.dart";
import 'DeuxiemeEcran.dart';
import 'Quizz.dart';
import 'Pages.dart';
import 'TroisiemeEcran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz Gabriel NAE',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      initialRoute: PageName.home,
      routes: {
        PageName.home: (context) => const HomePage(),
        PageName.quizz: (context) => const DeuxiemeEcran(),
        PageName.resultat: (context) => const TroisiemeEcran(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final quizzList = <Quizz>[const Quizz("histoire"), const Quizz("quizz2")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz'),
        backgroundColor: const Color.fromARGB(255, 47, 180, 107),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue, veuillez choisir un quizz',
              style: TextStyle(
                fontSize: 32,
                color: Color.fromARGB(255, 76, 159, 214),
              ),
            ),
            const SizedBox(height: 16),
            for (final Quizz item in quizzList)
              TheAmazingRow(
                couleur: const Color.fromARGB(255, 69, 214, 134),
                couleurTexte: const Color.fromARGB(255, 255, 255, 255),
                label: item.nomMaj,
              ),
          ],
        ),
      ),
    );
  }
}
