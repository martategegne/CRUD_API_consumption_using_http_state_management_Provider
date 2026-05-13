import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';
import '../models/photo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PhotoProvider>(context, listen: false).loadPhotos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Manager")),
      body: Consumer<PhotoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          return ListView.builder(
            itemCount: provider.photos.length,
            itemBuilder: (context, index) {
              final photo = provider.photos[index];

              return ListTile(
                leading: Image.network(photo.url, width: 50),
                title: Text(photo.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          provider.removePhoto(photo.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PhotoProvider>(context, listen: false).addPhoto(
            Photo(id: 0, title: "New Photo", url: "https://via.placeholder.com/150"),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}