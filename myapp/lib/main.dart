import 'package:flutter/material.dart';

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
      initialRoute: PageName.home, // Set the initial route
      routes: {
        PageName.home: (context) => const HomePage(),
        PageName.detail: (context) => const DeuxiemeEcran(),
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
  final quizzList = <Quizz>[const Quizz('quizz1'), const Quizz('quizz2')];

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
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 76, 159, 214),
              ),
            ),
            const SizedBox(height: 16),
            for (final Quizz item in quizzList)
              TheAmazingRow(
                label: item.nomMaj,
              ),
          ],
        ),
      ),
    );
  }
}

class DeuxiemeEcran extends StatelessWidget {
  const DeuxiemeEcran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(quizName),
      ),
      body: Center(),
    );
  }
}

class Quizz {
  final String nom;

  const Quizz(this.nom);

  String get nomMaj => nom.substring(0, 1).toUpperCase() + nom.substring(1);
}

class PageName {
  static const String home = '/';
  static const String detail = '/detail';
}

class TheAmazingRow extends StatelessWidget {
  const TheAmazingRow({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        PageName.detail,
        arguments: label,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 69, 214, 134),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align text in the center
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center, // Align text in the center
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
