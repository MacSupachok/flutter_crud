import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_test/src/API/users_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List listOfUser = [];

  Future<void> deleteUser(String id) async {
    try {
      var res = await http.post(Uri.parse(API.deleteData), body: {
        "idUser": id,
      });
      if (res.statusCode == 200) {
        Fluttertoast.showToast(msg: "Delete data successfully.");
        setState(() {
          listOfUser.removeWhere((user) => user['id'] == id);
          Navigator.pop(context);
        });
      } else {
        Fluttertoast.showToast(msg: "Someting went wrong, Try again.");
      }
    } catch (e) {
      print('Delete Error : ${e.toString()}');
    }
  }

  Future<void> getData() async {
    try {
      var res = await http.get(Uri.parse(API.readData));
      if (res.statusCode == 200) {
        // var responData = jsonDecode(res.body);
        setState(() {
          listOfUser = jsonDecode(res.body);
        });
      } else {
        Fluttertoast.showToast(msg: "Read data fail!");
      }
    } catch (e) {
      print('Read Error : ${e.toString()}');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orangeAccent,
        title: const Text('View Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh), // The refresh icon
            onPressed: () {
              // Add the logic to refresh your data here
              getData();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listOfUser.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                final user = listOfUser[index];
                Navigator.pushNamed(
                  context,
                  AppRoute.edit,
                  arguments: user,
                );
              },
              leading: const Icon(Icons.person),
              title: Text(listOfUser[index]['username']),
              subtitle: Text(listOfUser[index]['email']),
              trailing: IconButton(
                onPressed: () {
                  // deleteUser();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text('Are you sure you want to Delete?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                                deleteUser(listOfUser[index]['id']),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.insert);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
