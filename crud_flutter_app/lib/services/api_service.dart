import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl = "https://dummyjson.com";
  final String endpoint = "/users";

  
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "x-api-key": "reqres-free-v1",
  };

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers, 
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['users'];

      return (data as List)
          .map((e) => User.fromJson(e)) 
          .toList();
    } else {
      throw Exception("Failed to load users"); 
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint/add'),
      headers: headers, 
      body: jsonEncode(user.toJson()), 
    );

    if (response.statusCode == 201) {
      return user; 
    } else {
      throw Exception("Failed to create user"); 
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse("$baseUrl$endpoint/${user.id}"),
      headers: headers, 
      body: jsonEncode(user.toJson()), 
    );

    if (response.statusCode == 200) {
      return user; 
    } else {
      throw Exception("Failed to update user"); 
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl$endpoint/$id"),
      headers: headers, 
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete user"); 
    }
  }
}