import 'package:flutter/material.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
import 'package:stepup/data/shared_preferences/user.dart';

class Testpage extends StatefulWidget {
  const Testpage({super.key});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  SharePreHelper sharePreHelper = SharePreHelper();
  String text = "no data";
  User user = User(name: "Khoi", age: 18);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUser() async {
    User newUser = await sharePreHelper.getData() as User;
    text = newUser.name!;
    // print(newUser.name! + " " + newUser.age.toString());
    // text = newUser.name!;
    // print(text);
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TestPage"),
        ),
        body: Column(
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    sharePreHelper.saveData(user);
                  });
                },
                child: Text("SaveData")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    getUser();
                  });
                },
                child: Text("GetData")),
          ],
        ));
  }
}
