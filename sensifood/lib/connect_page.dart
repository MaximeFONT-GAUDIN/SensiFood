import 'package:flutter/material.dart';
import 'auth_pages.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilisation d'un Scaffold pour la structure de la page
      body: Center(
        // Centrer le contenu verticalement et horizontalement
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage du logo depuis les assets
            Image.asset(
              'assets/images/connect_page.png', // Chemin vers l'image dans le dossier assets
            ),
            const SizedBox(height: 40), // Espace entre le logo et le bouton "SE CONNECTER"
            
            // Bouton "SE CONNECTER"
            ElevatedButton(
              onPressed: () {
                // Lorsque le bouton est pressé, on navigue vers l'écran de connexion (LoginScreen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), // Passage à l'écran de connexion
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9765F), // Couleur personnalisée pour le bouton (couleur orange)
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Dimensions du bouton (large et haut)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Coins arrondis pour le bouton
                ),
              ),
              child: const Text(
                'SE CONNECTER', // Texte du bouton "SE CONNECTER"
                style: TextStyle(
                  fontSize: 18, // Taille de la police
                  fontWeight: FontWeight.bold, // Style en gras pour le texte
                  color: Colors.white, // Couleur du texte en blanc
                ),
              ),
            ),
            
            const SizedBox(height: 20), // Espace entre le bouton "SE CONNECTER" et le texte "CRÉER MON COMPTE"
            
            // Texte cliquable "CRÉER MON COMPTE"
            TextButton(
              onPressed: () {
                // Lorsque l'utilisateur clique sur le texte, il est redirigé vers l'écran d'inscription (SignupScreen)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()), // Passage à l'écran d'inscription
                  (Route<dynamic> route) => route.isFirst, // Supprime toutes les routes précédentes jusqu'à la première
                );
              },
              child: const Text(
                'CRÉER MON COMPTE', // Texte du bouton "CRÉER MON COMPTE"
                style: TextStyle(
                  fontSize: 16, // Taille de la police
                  fontWeight: FontWeight.w500, // Style semi-gras
                  color: Colors.black, // Couleur du texte en noir
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
