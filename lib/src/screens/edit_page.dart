// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../API/users_api.dart';
import '../routes.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditPage({Key? key, required this.user}) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  updateFunction() async {
    try {
      var res = await http.post(Uri.parse(API.updateData), body: {
        "idUser": widget.user['id'],
        "userName": userNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      if (res.statusCode == 200) {
        Fluttertoast.showToast(msg: "Update data successfully.");
      } else {
        Fluttertoast.showToast(msg: "Someting went wrong, Try again.");
      }
    } catch (e) {
      print('Update Error : ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    // Set default values in the controllers
    userNameController.text = widget.user['username'] ?? '';
    emailController.text = widget.user['email'] ?? '';
    passwordController.text = widget.user['password'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Edit Page"),
      ),
      // ---------------------------------------------------------------------------
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          // height: MediaQuery.of(context).size.height * 0.35,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Form Edit',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...formEditData(),
                      const SizedBox(height: 20),
                      ...formEditButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  formEditData() {
    return [
      TextFormField(
        controller: userNameController,
        decoration: const InputDecoration(
          labelText: "User Name",
        ),
        validator: (value) {
          if (value == "") {
            return "press enter your username";
          } else {
            return null;
          }
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: "Email",
        ),
        validator: (value) {
          if (value == "") {
            return "press enter your email";
          } else {
            return null;
          }
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        obscureText: true,
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: "Password",
        ),
        validator: (value) {
          if (value == "") {
            return "press enter your password";
          } else {
            return null;
          }
        },
      ),
    ];
  }

  formEditButton() {
    return [
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            updateFunction();
          }
        },
        child: const Text('Edit'),
      ),
      const SizedBox(height: 20),
      OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.view);
        },
        child: const Text('View Data'),
      ),
    ];
  }
}
