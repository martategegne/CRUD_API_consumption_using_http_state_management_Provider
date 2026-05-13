import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/api_service.dart';

class PhotoProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Photo> photos = [];
  bool isLoading = false;
  String? error;

  Future<void> loadPhotos() async {
    try {
      isLoading = true;
      notifyListeners();

      photos = await _api.fetchPhotos();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPhoto(Photo photo) async {
    final newPhoto = await _api.createPhoto(photo);
    photos.add(newPhoto);
    notifyListeners();
  }

  Future<void> editPhoto(Photo photo) async {
    final updated = await _api.updatePhoto(photo);
    int index = photos.indexWhere((p) => p.id == photo.id);
    photos[index] = updated;
    notifyListeners();
  }

  Future<void> removePhoto(int id) async {
    await _api.deletePhoto(id);
    photos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}