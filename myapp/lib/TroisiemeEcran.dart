import 'package:flutter/material.dart';
import 'Pages.dart';
import 'globalEssais.dart';

class TroisiemeEcran extends StatelessWidget {
  const TroisiemeEcran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int tentative = globalEssais;
    String tentaString = tentative.toString();
    globalEssais = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
        backgroundColor: const Color.fromARGB(255, 47, 180, 107),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Voici votre nombre de tentatives: $tentaString',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 76, 159, 214),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  PageName.home,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 180, 107),
              ),
              child: const Text("Page d'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
