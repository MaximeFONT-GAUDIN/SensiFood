import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sensifood/home_page.dart';
import 'package:sensifood/auth_pages.dart';

class ApiService {
  static const String apiUrl = 'http://10.0.2.2:3000'; // Remplace par ton URL d'API

  // Fonction pour créer un utilisateur
  Future<String> registerUser(BuildContext context, String email, String password, String name) async {
    final Map<String, dynamic> registrationData = {
      'email': email,
      'password': password,
      'name': name,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registrationData),
    );

    var json = jsonDecode(response.body);

    try {
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => route.isFirst,
        );
        return "success";
      } else {
        return "'${json['message']}'";
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  // Fonction pour connecter un utilisateur et récupérer le token
  Future<String?> loginUser(BuildContext context, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('$apiUrl/auth/signin'));
    request.body = jsonEncode({
      'email': email,
      'password': password,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);

        String token = jsonData['access_token'];
        String name = jsonData['user']['name'];
        List<dynamic> allergens = jsonData['user']['allergens'];

        // Extraire les noms des allergènes
        List<String> allergenNames = [];
        if (allergens.isNotEmpty) {
          for (var allergen in allergens) {
            allergenNames.add(allergen['name']);
          }
        }

        // Sauvegarder les données utilisateur dans SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        await prefs.setStringList('allergens', allergenNames);  // Sauvegarder les allergènes sous forme de liste de chaînes

        // Rediriger vers la page d'accueil après connexion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
        );

        return 'success';
      } else {
        return response.reasonPhrase ?? 'Erreur inconnue';
      }
    } catch (e) {
      return 'Erreur lors de la connexion : $e';
    }
  }
}
