import 'package:flutter/material.dart';

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
