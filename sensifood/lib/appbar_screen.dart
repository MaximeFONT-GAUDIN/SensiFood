import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Ajoute un peu d'espace autour du contenu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu à gauche
        children: [
          const Text(
            'Bienvenue Louise',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16.0), // Espacement entre le titre et la barre de recherche
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFFD9765F)),
              ),
              hintText: 'Chercher',
              prefixIcon: const Icon(Icons.search), // Icône de recherche
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Mon Tableau de bord',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ceci est l\'écran Scanner', style: TextStyle(fontSize: 24)),
    );
  }
}

class SuiviScreen extends StatelessWidget {
  const SuiviScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ceci est l\'écran Suivi', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ceci est l\'écran Profil', style: TextStyle(fontSize: 24)),
    );
  }
}

class PlusScreen extends StatelessWidget {
  const PlusScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ceci est l\'écran Plus', style: TextStyle(fontSize: 24)),
    );
  }
}
