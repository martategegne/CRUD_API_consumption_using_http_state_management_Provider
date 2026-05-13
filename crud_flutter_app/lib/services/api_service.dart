import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/photos";

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.take(20).map((e) => Photo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }

  Future<Photo> createPhoto(Photo photo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(photo.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      return Photo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create photo");
    }
  }

  Future<Photo> updatePhoto(Photo photo) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${photo.id}"),
      body: jsonEncode(photo.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Photo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update photo");
    }
  }

  Future<void> deletePhoto(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete photo");
    }
  }
}