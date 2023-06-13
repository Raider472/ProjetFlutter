import 'package:flutter/material.dart';
import 'Quizz.dart';
import 'TheAmazingRow.dart';
import 'Pages.dart';
import 'globalEssais.dart';

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

    if (quizName == "Histoire") {
      couleurAppBar = const Color.fromARGB(255, 6, 87, 116);
      questionQuizz = <QuestionQuizzHistoire>[
        const QuestionQuizzHistoire(
            "En quelle année l'Union Soviétique à t-elle obtenue la bombe H ?",
            ["1953", "1968", "1991", "1450"],
            "1953"),
        const QuestionQuizzHistoire("En quelle année a été crée l'imprimerie ?",
            ["1918", "476", "1450", "1244"], "1450"),
        const QuestionQuizzHistoire(
            "Quel général Américain a voulu larguer une bombe atomique en Chine lors de la guerre de Corée ?",
            [
              "Dwight D. Eisenhower",
              "François Hollande",
              "Douglas MacArthur",
              "George S. Patton"
            ],
            "Douglas MacArthur"),
        const QuestionQuizzHistoire(
            "Comment s'appellait l'empereur de l'empire mongol",
            [
              "Tchang Kaï-chek",
              "Gengis Khan",
              "Oda nobunaga",
              "Franklin D. Roosevelt"
            ],
            "Gengis Khan"),
      ];
    } else if (quizName == "Capitale") {
      couleurAppBar = const Color.fromARGB(255, 90, 97, 107);
      questionQuizz = <QuestionQuizzHistoire>[
        const QuestionQuizzHistoire(
            "Quel est la capitale de la France ?", [], "Paris"),
        const QuestionQuizzHistoire(
            "Quel est la capitale de l'Allemagne ?", [], "Berlin"),
        const QuestionQuizzHistoire(
            "Quel est la capitale de la Roumanie ?", [], "Bucarest"),
        const QuestionQuizzHistoire(
            "Quel est la capitale du Cambodge ?", [], "Phnom Penh"),
      ];
    } else {
      couleurAppBar = const Color.fromARGB(255, 47, 180, 107);
      questionQuizz = <QuestionQuizzHistoire>[
        const QuestionQuizzHistoire("erreur, pas de contexte", [], "contexte"),
      ];
    }

    void verifieurReponse(String valeur, String reponse) {
      globalEssais++;
      if (reponse == valeur) {
        final newIndex = index + 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Bonne réponse"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
        if (newIndex >= questionQuizz.length) {
          Navigator.pushReplacementNamed(context, PageName.resultat);
        } else {
          Navigator.pushReplacementNamed(
            context,
            PageName.quizz,
            arguments: {
              "quizzName": quizName,
              "index": newIndex,
            },
          );
        }
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

    if (quizName == null) {
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                        questionQuizz: questionQuizz,
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
