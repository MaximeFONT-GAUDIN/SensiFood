import 'package:flutter/material.dart';
import 'package:sensifood/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

// Classe LoginScreen qui représente l'écran de connexion
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// État associé à l'écran de connexion
class _LoginScreenState extends State<LoginScreen> {
  // Contrôleurs pour capturer le texte des champs email et mot de passe
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Clé pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // Instance du service API pour effectuer la connexion
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Définition de la couleur de fond de l'écran (ici un marron foncé)
      backgroundColor: const Color(0xFFD9765F),
      
      // Corps principal de l'écran, centré à l'écran
      body: Center(
        child: SingleChildScrollView(
          // Ajout de padding pour espacer le contenu des bords
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titre de l'application affiché en haut
                const Text(
                  'SensiFood',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40), // Espace entre le titre et le formulaire
                
                // Conteneur blanc qui va contenir le formulaire
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, // Fond blanc pour le formulaire
                    borderRadius: BorderRadius.circular(20), // Coins arrondis du conteneur
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // Ombre douce pour un effet en relief
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  
                  // Formulaire de connexion
                  child: Form(
                    key: _formKey, // Clé pour la validation du formulaire
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre de la section du formulaire
                        const Text(
                          'Connexion',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD9765F),
                          ),
                        ),
                        const SizedBox(height: 20), // Espace avant le premier champ de saisie

                        // Champ de saisie pour l'email
                        TextFormField(
                          controller: _emailController, // Contrôleur lié à ce champ
                          keyboardType: TextInputType.emailAddress, // Clavier spécifique pour la saisie d'un email
                          decoration: const InputDecoration(
                            labelText: 'Adresse mail', // Étiquette du champ
                            border: OutlineInputBorder(), // Style de la bordure du champ
                          ),
                          // Validation : vérifier que le champ n'est pas vide
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre adresse mail';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16), // Espace entre les champs

                        // Champ de saisie pour le mot de passe
                        TextFormField(
                          controller: _passwordController, // Contrôleur lié à ce champ
                          obscureText: true, // Masquer le texte (mot de passe)
                          decoration: const InputDecoration(
                            labelText: 'Mot de passe', // Étiquette du champ
                            border: OutlineInputBorder(), // Bordure du champ
                          ),
                          // Validation : vérifier que le champ n'est pas vide
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 20), // Espace avant le bouton de connexion

                        // Bouton de connexion
                        ElevatedButton(
                          // Action lorsqu'on appuie sur le bouton
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Si le formulaire est valide, on appelle l'API pour se connecter
                              String? loginResult = await _apiService.loginUser(
                                context,
                                _emailController.text,
                                _passwordController.text,
                              );
                              
                              if (loginResult == 'success') {
                                // Si la connexion réussit, rediriger vers la page d'accueil
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Connecté avec succès!')),
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                  (Route<dynamic> route) => false,
                                );
                              } else {
                                // Afficher un message d'erreur si la connexion échoue
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loginResult ?? 'Erreur de connexion')),
                                );
                              }
                            }
                          },
                          
                          // Style du bouton de connexion
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9765F), // Couleur du bouton
                            padding: const EdgeInsets.symmetric(vertical: 15), // Espace à l'intérieur du bouton
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Coins arrondis du bouton
                            ),
                          ),
                          
                          // Texte à l'intérieur du bouton
                          child: const Center(
                            child: Text(
                              'Connexion',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white, // Couleur du texte du bouton
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espace après le formulaire

                // Lien pour créer un compte si l'utilisateur n'en a pas
                TextButton(
                  onPressed: () {
                    // Redirection vers l'écran de création de compte
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                      (Route<dynamic> route) => route.isFirst,
                    );
                  },
                  child: const Text(
                    'VOUS N\'AVEZ PAS DE COMPTE ?',
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte du bouton
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key}); // Constructeur de la classe SignupScreen

  @override
  _SignupScreenState createState() => _SignupScreenState(); // Création de l'état de l'écran d'inscription
}

class _SignupScreenState extends State<SignupScreen> {
  // Contrôleurs pour gérer l'entrée utilisateur
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  // Clé pour le formulaire, utilisée pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // Instance de ApiService pour gérer les requêtes API
  final ApiService _apiService = ApiService();

  // Fonction pour sauvegarder les données utilisateur localement
  Future<void> _saveUserData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance(); // Obtention d'une instance de SharedPreferences
    await prefs.setString('email', email); // Sauvegarde de l'email
    await prefs.setString('password', password); // Sauvegarde du mot de passe
    await prefs.setString('name', _nameController.text); // Sauvegarde du nom
  }

  // Fonction pour envoyer le formulaire
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) { // Vérification de la validité du formulaire
      // Envoi des données au serveur et réception de la réponse
      String responseMessage = await _apiService.registerUser(
        context,
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      // Gestion de la réponse du serveur
      if (responseMessage == 'success') {
        await _saveUserData(_emailController.text, _passwordController.text); // Sauvegarde des données utilisateur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compte créé avec succès!')), // Message de succès
        );
      } else {
        // Affichage de l'erreur retournée par l'API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $responseMessage')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9765F), // Couleur de fond de l'écran
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Ajout de padding autour de l'écran
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrage du contenu
              children: [
                const Text(
                  'SensiFood',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Couleur du texte
                  ),
                ),
                const SizedBox(height: 40), // Espacement vertical
                Container(
                  padding: const EdgeInsets.all(20), // Padding à l'intérieur du conteneur
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur de fond du conteneur
                    borderRadius: BorderRadius.circular(20), // Coins arrondis
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // Couleur de l'ombre
                        blurRadius: 10, // Flou de l'ombre
                        offset: Offset(0, 5), // Décalage de l'ombre
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey, // Assignation de la clé de formulaire
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alignement du texte
                      children: [
                        const Center(
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD9765F), // Couleur du texte
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Espacement vertical
                        TextFormField(
                          controller: _emailController, // Contrôleur pour le champ email
                          keyboardType: TextInputType.emailAddress, // Type de clavier pour l'email
                          decoration: const InputDecoration(
                            labelText: 'Adresse mail', // Étiquette du champ
                            border: OutlineInputBorder(), // Bordure du champ
                          ),
                          validator: (value) {
                            // Validation du champ email
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre adresse mail'; // Message d'erreur
                            }
                            return null; // Pas d'erreur
                          },
                        ),
                        const SizedBox(height: 16), // Espacement vertical
                        TextFormField(
                          controller: _passwordController, // Contrôleur pour le champ mot de passe
                          obscureText: true, // Masque le mot de passe
                          decoration: const InputDecoration(
                            labelText: 'Mot de passe', // Étiquette du champ
                            border: OutlineInputBorder(), // Bordure du champ
                          ),
                          validator: (value) {
                            // Validation du champ mot de passe
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe'; // Message d'erreur
                            }
                            return null; // Pas d'erreur
                          },
                        ),
                        const SizedBox(height: 16), // Espacement vertical
                        TextFormField(
                          controller: _nameController, // Contrôleur pour le champ nom
                          decoration: const InputDecoration(
                            labelText: 'Prénom et Nom', // Étiquette du champ
                            border: OutlineInputBorder(), // Bordure du champ
                          ),
                          validator: (value) {
                            // Validation du champ nom
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer vos nom et prénom'; // Message d'erreur
                            }
                            return null; // Pas d'erreur
                          },
                        ),
                        const SizedBox(height: 20), // Espacement vertical
                        ElevatedButton(
                          onPressed: _submitForm, // Appel de la fonction de soumission
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9765F), // Couleur de fond du bouton
                            padding: const EdgeInsets.symmetric(vertical: 15), // Espacement vertical
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Coins arrondis du bouton
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Créer mon compte', // Texte du bouton
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white, // Couleur du texte
                                fontWeight: FontWeight.bold, // Poids du texte
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espacement vertical
                TextButton(
                  onPressed: () {
                    // Navigation vers l'écran de connexion
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false, // Supprime toutes les routes précédentes
                    );
                  },
                  child: const Text(
                    'VOUS AVEZ DEJA UN COMPTE ?', // Texte du bouton
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontWeight: FontWeight.w500, // Poids du texte
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
