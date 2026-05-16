import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<User> users = [];
  bool isLoading = false;
  String? error;

  Future<void> loadUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      users = await _api.fetchUsers();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(User user) async {
    try {
      users.insert(0, user);
      notifyListeners();
      _api.createUser(user);
    } catch (_) {
      
    }
  }

 
  Future<void> editUser(User user) async {
    try {
      int index = users.indexWhere((u) => u.id == user.id);

      if (index != -1) {
        users[index] = user;
        notifyListeners();
      }

      
      _api.updateUser(user);
    } catch (_) {
      
    }
  }

  
  Future<void> removeUser(int id) async {
    try {
      users.removeWhere((u) => u.id == id);
      notifyListeners();

     
      _api.deleteUser(id);
    } catch (_) {
      
    }
  }
}