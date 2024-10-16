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

  Future<Map<String, dynamic>?> fetchProductInfo(String barcode) async {
    try {
      // Récupérer le jeton d'authentification depuis les préférences partagées
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token manquant');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/product/$barcode'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Impression de débogage
      // print('Réponse de l\'API : ${response.statusCode}');
      // print('Corps de la réponse : ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'appel API : $e');
      return null;
    }
  }
// Fonction pour récupérer les informations du produit
  Future<Map<String, dynamic>?> getProductInfo(String barcode) async {
    try {
      // Récupérer le jeton d'authentification depuis les préférences partagées
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token manquant');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/product/$barcode'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Impression de débogage
      print('Réponse de l\'API : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'appel API : $e');
      return null;
    }
  }

  // Fonction pour récupérer les recettes
  Future<dynamic> getReceipts(String category) async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
    var headers =  {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

    var request = http.Request('GET', Uri.parse('$apiUrl/product/receipt/$category'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);

        // Ajout d'une instruction de débogage pour imprimer les données de réponse
        print('Response Data: $jsonData');

        return jsonData['receipts'];
      } else {

        print(response.reasonPhrase);
        throw Exception('Failed to fetch receipts');
      }
    } catch (e) {
      throw Exception('Failed to fetch receipts: $e');
    }
  }

  // Fonction pour récupérer les informations des recettes alternatives
  Future<List<dynamic>> getAlternativeReceipts() async {
    var headers = {'Content-Type': 'application/json'};

    // Récupérer le jeton d'authentification depuis les préférences partagées
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token manquant');
    }

    headers['Authorization'] = 'Bearer $token';

    var request = http.Request('POST', Uri.parse('$apiUrl/product/alternative'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);

        return jsonData['alternatives'];
      } else {
        throw Exception('Failed to fetch alternative receipts');
      }
    } catch (e) {
      throw Exception('Failed to fetch alternative receipts: $e');
    }
  }
  
  // Fonction pour récupérer les informations sur les allergies des utilisateurs
  Future<List<dynamic>> getUserAllergens() async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('$apiUrl/user/allergens'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);

        return jsonData['allergens'];
      } else {
        throw Exception('Failed to fetch user allergens');
      }
    } catch (e) {
      throw Exception('Failed to fetch user allergens: $e');
    }
  }


}