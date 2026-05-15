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
  try {
    final newPhoto = await _api.createPhoto(photo);

    final fixedPhoto = Photo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: newPhoto.title,
      url: newPhoto.url,
    );

    photos.insert(0, fixedPhoto);
    notifyListeners();
  } catch (e) {
    error = e.toString();
    notifyListeners();
  }
}

  Future<void> editPhoto(Photo photo) async {
  try {
    final updated = await _api.updatePhoto(photo);

    int index = photos.indexWhere((p) => p.id == photo.id);

    if (index != -1) {
      photos[index] = updated;
      notifyListeners();
    }
  } catch (e) {
    error = e.toString();
    notifyListeners();
  }
}

  Future<void> removePhoto(int id) async {
    await _api.deletePhoto(id);
    photos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}