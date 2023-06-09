import 'package:flutter/material.dart';
import 'Pages.dart';
import 'Quizz.dart';
import 'globalEssais.dart';

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
    required this.questionQuizz,
  }) : super(key: key);

  final String label;
  final Color couleur;
  final Color couleurTexte;
  final String reponseActuelle;
  final String reponseCorrecte;
  final String quizName;
  final int index;
  final List<QuestionQuizzHistoire> questionQuizz;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        globalEssais++;
        if (reponseActuelle == reponseCorrecte) {
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
