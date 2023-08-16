import 'package:flutter/material.dart';
import 'package:flutter_crud_test/src/API/users_api.dart';
import 'package:flutter_crud_test/src/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  insertFunction() async {
    try {
      var res = await http.post(Uri.parse(API.insertData), body: {
        "userName": userNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      if (res.statusCode == 200) {
        Fluttertoast.showToast(msg: "Insert data successfully.");
        userNameController.clear();
        emailController.clear();
        passwordController.clear();
        formKey.currentState?.reset();
      } else {
        Fluttertoast.showToast(msg: "Someting went wrong, Try again.");
      }
    } catch (e) {
      print('Insert Error : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Insert Page"),
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
                          'Form Insert',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...formInsertData(),
                      const SizedBox(height: 20),
                      ...formInsertButton(),
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

  formInsertData() {
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

  formInsertButton() {
    return [
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            insertFunction();
          }
        },
        child: const Text('Insert'),
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
