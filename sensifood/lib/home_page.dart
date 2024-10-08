import 'package:flutter/material.dart';
import 'auth_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'assets/images/connect_page.png',
            ),
            const SizedBox(height: 40), // Espace entre le logo et le bouton
            // Bouton "SE CONNECTER"
            ElevatedButton(
              onPressed: () {
                // Ajouter l'action pour se connecter ici
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9765F), // Couleur verte foncée pour le bouton
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'SE CONNECTER',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espace entre le bouton et le texte
            // Texte "CRÉER MON COMPTE"
            TextButton(
              onPressed: () {
                // Ajouter l'action pour créer un compte ici
                Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => SingupScreen()),
                (Route<dynamic> route) => route.isFirst,
                );
              },
              child: const Text(
                'CRÉER MON COMPTE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}