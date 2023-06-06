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
        PageName.quizz: (context) => const DeuxiemeEcran(),
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

class DeuxiemeEcran extends StatelessWidget {
  const DeuxiemeEcran({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String? quizName = arguments?["quizzName"] as String?;
    final index = arguments?["index"] as int? ?? 0;
    Color couleurAppBar;
    List<QuestionQuizzHistoire> questionQuizz;
    TextEditingController valeurTextField = TextEditingController();

    void verifieurReponse(String valeur, String reponse) {
      if (reponse == valeur) {
        final newIndex = index + 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Bonne réponse"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushNamed(
          context,
          PageName.quizz,
          arguments: {
            "quizzName": quizName,
            "index": newIndex,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mauvaise réponse"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    }

    if (quizName == "Histoire") {
      couleurAppBar = const Color.fromARGB(255, 6, 87, 116);
      questionQuizz = <QuestionQuizzHistoire>[
        const QuestionQuizzHistoire(
            "En quelle année l'Union Soviétique à t-elle obtenue la bombe H ?",
            ["1953", "1968", "1991", "1450"],
            "1953"),
        const QuestionQuizzHistoire(
            "En quelle année a été crée l'imprimerie ?", [], "1450"),
        const QuestionQuizzHistoire(
            "Quel général Américain a voulu larguer une bombe atomique en Chine lors de la guerre de Corée ?",
            [
              "Dwight D. Eisenhower",
              "François Hollande",
              "Douglas MacArthur",
              "George S. Patton"
            ],
            "Douglas MacArthur"),
      ];
    } else {
      couleurAppBar = const Color.fromARGB(255, 47, 180, 107);
      questionQuizz = <QuestionQuizzHistoire>[
        const QuestionQuizzHistoire("erreur, pas de contexte", [], "contexte"),
      ];
    }
    if (quizName == null) {
      // Handle the case when quizName is null
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text("Veulliez ne pas recharger la page lors du quizz"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(quizName),
          backgroundColor: couleurAppBar,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(questionQuizz[index].questionMaj,
                style: const TextStyle(
                  fontSize: 28,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align rows at the center
                children: [
                  if (questionQuizz[index].possibleReponsesList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: valeurTextField,
                            decoration: const InputDecoration(
                              labelText: "Entrer la réponse",
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              verifieurReponse(valeurTextField.text,
                                  questionQuizz[index].reponse);
                            },
                            child: const Text('confirmer la réponse'),
                          ),
                        ],
                      ),
                    ),
                  if (questionQuizz[index].possibleReponsesList.isNotEmpty)
                    for (int i = 0;
                        i < questionQuizz[index].possibleReponsesList.length;
                        i++)
                      TheAmazingRowQuizz(
                        couleur: const Color.fromARGB(255, 6, 87, 116),
                        couleurTexte: const Color.fromARGB(255, 255, 255, 255),
                        label: questionQuizz[index].possibleReponsesList[i],
                        reponseActuelle:
                            questionQuizz[index].possibleReponsesList[i],
                        reponseCorrecte: questionQuizz[index].reponse,
                        quizName: quizName,
                        index: index,
                      ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class Quizz {
  final String nom;

  const Quizz(this.nom);

  String get nomMaj => nom.substring(0, 1).toUpperCase() + nom.substring(1);
}

class QuestionQuizzHistoire {
  final String question;
  final List<String> possibleReponse;
  final String reponse;

  const QuestionQuizzHistoire(
      this.question, this.possibleReponse, this.reponse);

  String get questionMaj =>
      question.substring(0, 1).toUpperCase() + question.substring(1);
  String get reponseMaj =>
      reponse.substring(0, 1).toUpperCase() + reponse.substring(1);

  List<String> get possibleReponsesList => possibleReponse;
}

class PageName {
  static const String home = '/';
  static const String quizz = '/quizz';
}

class TheAmazingRow extends StatelessWidget {
  const TheAmazingRow({
    Key? key,
    required this.label,
    required this.couleur,
    required this.couleurTexte,
  }) : super(key: key);

  final String label;
  final Color couleur;
  final Color couleurTexte;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        PageName.quizz,
        arguments: {
          "quizzName": label,
          "index": 0,
        },
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: couleur,
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
                  style: TextStyle(
                    fontSize: 18,
                    color: couleurTexte,
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

class TheAmazingRowQuizz extends StatelessWidget {
  const TheAmazingRowQuizz({
    Key? key,
    required this.label,
    required this.couleur,
    required this.couleurTexte,
    required this.reponseActuelle,
    required this.reponseCorrecte,
    required this.quizName,
    required this.index,
  }) : super(key: key);

  final String label;
  final Color couleur;
  final Color couleurTexte;
  final String reponseActuelle;
  final String reponseCorrecte;
  final String quizName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (reponseActuelle == reponseCorrecte) {
          final newIndex = index + 1;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Bonne réponse"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.pushNamed(
            context,
            PageName.quizz,
            arguments: {
              "quizzName": quizName,
              "index": newIndex,
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Mauvaise réponse"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: couleur,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    color: couleurTexte,
                  ),
                  textAlign: TextAlign.center,
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
