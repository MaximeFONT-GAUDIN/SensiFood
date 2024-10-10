import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String? userName;
  List<String> allergens = []; // Liste pour stocker les allergènes

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Charger les données utilisateur et allergènes
  }

  // Fonction pour récupérer les données utilisateur et allergènes à partir de SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Invité'; // Récupère le nom stocké, ou 'Invité' si null
      allergens = prefs.getStringList('allergens') ?? []; // Récupère la liste des allergènes ou une liste vide
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu à gauche
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Bienvenue ${userName?.split(' ')[0] ?? '...'}',
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16.0), // Espacement entre le titre et la barre de recherche
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Color(0xFFD9765F)),
                ),
                hintText: 'Chercher',
                prefixIcon: const Icon(Icons.search), // Icône de recherche
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Mon Tableau de bord',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Mes allergies',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16.0), // Espacement avant d'afficher les allergènes

            // Affichage des allergènes deux par deux
            allergens.isNotEmpty
                ? Column(
                    children: _buildAllergenRows(context), // Générer les lignes d'allergènes
                  )
                : const Text('Aucun allergène trouvé', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer les lignes de deux allergènes
  List<Widget> _buildAllergenRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < allergens.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(
              flex: 1, // Première colonne pour l'allergène aligné à gauche
              child: Text(
                allergens[i],
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.start, // Aligner à gauche
              ),
            ),
            // const Spacer(flex: 1), // Espace entre les deux allergènes
            // Espace contrôlé entre les deux allergènes
            const SizedBox(width: 10),
            Expanded(
              flex: 1, // Deuxième colonne pour l'allergène centré
              child: i + 1 < allergens.length // Vérifier s'il y a un deuxième allergène à afficher
                  ? Text(
                      allergens[i + 1],
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center, // Aligner au centre
                    )
                  : Container(), // Si pas de deuxième allergène, on met un conteneur vide
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 16)); // Espacement vertical entre les lignes
    }
    return rows;
  }
}




class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String barcode = "";

  Future<void> scanBarcode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );

    if (result != null) {
      setState(() {
        barcode = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner de Code-Barres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Résultat du scan : $barcode',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanBarcode,
              child: const Text('Scanner un Code-Barres'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuiviScreen extends StatelessWidget {
  const SuiviScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ceci est l\'écran Suivi', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ceci est l\'écran Profil', style: TextStyle(fontSize: 24)),
    );
  }
}

class PlusScreen extends StatelessWidget {
  const PlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ceci est l\'écran Plus', style: TextStyle(fontSize: 24)),
    );
  }
}

// Widget pour afficher la légende (indicateur)
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = true,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        )
      ],
    );
  }
}
