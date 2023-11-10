import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aksje_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:aksje_app/widgets/screens/main_page.dart';

class AddListPage extends  StatefulWidget {
  const AddListPage({Key? key}) : super(key: key);

  @override
  _AddListPage createState() => _AddListPage();
}

class _AddListPage extends State<AddListPage> {

  final TextEditingController nameController = TextEditingController();

  Future<void> createList(BuildContext context, String name) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    var uid = userProvider.user!.uid;
    print(uid);
    var baseURL = Uri.parse('http://10.0.2.2:8080/api/list');
    var body = jsonEncode({
      "name": name,
      "user": {
        "uid": uid
      }
    });
    try {
      var response = await http.post(
        baseURL,
        headers: <String, String> {
          'Content-Type':'application/json; charset=UTF-8',
        },
        body: body,
      );
      if(response.statusCode == 201) {
        print('List created');
      }else if (response.statusCode == 400) {
        var errorMessage = json.decode(response.body);
        print('Error message: $errorMessage');
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
        );
      }
    }
    catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add List"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, 
            MaterialPageRoute(
              builder: (context) => const MainPage(selectedIndex: 1),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "New List Name",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                createList(context, name);
              }, 
              child: const Text('Create List'))
          ],
        ),
      )

    );
  }
}