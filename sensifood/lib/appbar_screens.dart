import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Charger le nom de l'utilisateur au démarrage du widget
  }

  // Fonction pour récupérer le nom de l'utilisateur à partir de SharedPreferences
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Invité'; // Récupère le nom stocké, ou 'Invité' si null
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu à gauche
          children: [
            Text(
              'Bienvenue ${userName?.split(' ')[0] ?? '...'}',
              style: TextStyle(fontSize: 24),
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
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16.0), // Espacement avant le graphique
            Row(
              children: [
                // Graphique camembert
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1, // Rend le graphique camembert carré
                    child: PieChart(
                      PieChartData(
                        sections: showingSections(), // Les sections du camembert
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40, // Espace au centre
                        sectionsSpace: 4, // Espace entre les sections
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0), // Espacement entre le graphique et la légende
                // Légende à côté du graphique
                const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xFFE0795D),
                        text: 'Pollen',
                        isSquare: true,
                      ),
                      SizedBox(height: 8),
                      Indicator(
                        color: Color(0xFFE79B85),
                        text: 'Arrachides',
                        isSquare: true,
                      ),
                      SizedBox(height: 8),
                      Indicator(
                        color: Color(0xFFEFBCAE),
                        text: 'Asthme',
                        isSquare: true,
                      ),
                      SizedBox(height: 8),
                      Indicator(
                        color: Color(0xFFF7DED6),
                        text: 'Autre',
                        isSquare: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour configurer les sections du graphique camembert
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: const Color(0xFFE0795D),
        value: 40, // Valeur en pourcentage
        title: '40%', // Label
        radius: 50, // Taille de la part
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: const Color(0xFFE79B85),
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: const Color(0xFFEFBCAE),
        value: 20,
        title: '20%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: const Color(0xFFF7DED6),
        value: 10,
        title: '10%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ceci est l\'écran Scanner', style: TextStyle(fontSize: 24)),
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
