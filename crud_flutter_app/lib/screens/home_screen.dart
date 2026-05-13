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
                leading: SizedBox(
  width: 50,
  height: 50,
  child: Image.network(
    "https://picsum.photos/id/${photo.id}/100/100",
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.broken_image);
    },
  ),
),
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
            Photo(id: 0, title: "New Photo",
             url: "https://picsum.photos/id/${DateTime.now().millisecondsSinceEpoch % 1000}/200/200" ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}