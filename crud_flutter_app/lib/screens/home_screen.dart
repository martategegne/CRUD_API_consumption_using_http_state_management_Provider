import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<UserProvider>(context, listen: false).loadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Manager")),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          return ListView.builder(
            itemCount: provider.users.length, 
            itemBuilder: (context, index) {
              final user = provider.users[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      user.avatar.isNotEmpty
                          ? user.avatar
                          : "https://picsum.photos/200",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text("Email: ${user.email}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          final firstNameController =
                              TextEditingController(text: user.firstName);
                          final lastNameController =
                              TextEditingController(text: user.lastName);
                          final emailController =
                              TextEditingController(text: user.email);

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Edit User"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: firstNameController,
                                    decoration: InputDecoration(hintText: "First Name"),
                                  ),
                                  TextField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(hintText: "Last Name"),
                                  ),
                                  TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(hintText: "Email"),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    provider.editUser(User(
                                      id: user.id,
                                      firstName: firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      avatar: user.avatar,
                                    ));
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // 🗑 DELETE
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.removeUser(user.id),
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
          final firstNameController = TextEditingController();
          final lastNameController = TextEditingController();
          final emailController = TextEditingController();

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Add User"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(hintText: "First Name"),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false).addUser(
                      User(
                        id: DateTime.now().millisecondsSinceEpoch,
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email: emailController.text.trim(),
                        avatar: "https://picsum.photos/200",
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}