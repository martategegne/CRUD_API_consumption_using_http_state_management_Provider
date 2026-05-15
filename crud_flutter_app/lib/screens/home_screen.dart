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

              return Card(
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  child: ListTile(
                leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: SizedBox(
    width: 60,
    height: 60,
    child: Image.network(
  photo.url.isNotEmpty
      ? photo.url
      : "https://picsum.photos/200",
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Image.network(
      "https://picsum.photos/200",
      fit: BoxFit.cover,
    );
  },
),
),
),
                title: Text(
  photo.title,
  style: const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  ),
),
subtitle: Text(
  "Photo ID: ${photo.id}",
  style: const TextStyle(color: Colors.grey),
),
                trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [

    IconButton(
      icon: const Icon(Icons.edit, color: Colors.blue),
      onPressed: () {
        TextEditingController titleController =
    TextEditingController(text: photo.title);

TextEditingController urlController =
    TextEditingController(text: photo.url);

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Edit Photo"),
            content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    TextField(
      controller: titleController,
      decoration: const InputDecoration(
        hintText: "Enter photo title",
      ),
    ),
    const SizedBox(height: 10),
    TextField(
      controller: urlController,
      decoration: const InputDecoration(
        hintText: "Enter image URL",
      ),
    ),
  ],
),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  provider.editPhoto(
  Photo(
    id: photo.id,
    title: titleController.text,
    url: urlController.text.isEmpty
        ? photo.url
        : urlController.text,
  ),
);
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          ),
        );
      },
    ),

    IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => provider.removePhoto(photo.id),
    ),
  ],
),
              ),
);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Photo"),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Enter photo title",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              
              onPressed: () {
                TextEditingController titleController = TextEditingController();
TextEditingController urlController = TextEditingController();
                Provider.of<PhotoProvider>(context, listen: false).addPhoto(
                  Photo(
  id: DateTime.now().millisecondsSinceEpoch,
  title: titleController.text.isEmpty
      ? "Untitled Photo"
      : titleController.text,
  url: urlController.text.isEmpty
      ? "https://picsum.photos/200"
      : urlController.text,
),
                );
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  },
  child: const Icon(Icons.add),
),
    );
  }
}