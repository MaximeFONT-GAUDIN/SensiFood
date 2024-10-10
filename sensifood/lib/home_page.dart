import 'package:flutter/material.dart';
import 'package:sensifood/appbar_screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Liste des écrans associés à chaque élément de la barre de navigation
  static final List<Widget> _widgetOptions = <Widget>[
    const MenuScreen(),
    ScannerScreen(),
    const SuiviScreen(),
    const ProfilScreen(),
    const PlusScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/appbar_logo.png'), // Logo de l'application
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu), // Menu hamburger
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Ouvrir le drawer
              },
            ),
          ),
        ],
        elevation: 8,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
      ),
      // Drawer qui s'ouvre à droite
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header du drawer
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFD9765F), // Couleur du header
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Liste des éléments du menu
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Tableau de bord'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                // Action pour naviguer vers Tableau de bord
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Mes produits'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                // Action pour naviguer vers Mes produits
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Mes recettes'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                // Action pour naviguer vers Mes recettes
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes),
              title: const Text('Mon suivi'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                // Action pour naviguer vers Mon suivi
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                // Action pour naviguer vers Mon profil
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Suivi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Plus',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD9765F),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}