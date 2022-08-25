import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_tutorial/Models/userModel.dart';

class Example_Three extends StatefulWidget {
  const Example_Three({Key? key}) : super(key: key);

  @override
  _Example_ThreeState createState() => _Example_ThreeState();
}

class _Example_ThreeState extends State<Example_Three> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('UserApi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  name: 'Name',
                                  value: snapshot.data![index].name.toString()),
                              ReusableRow(
                                  name: 'userName',
                                  value: snapshot.data![index].username
                                      .toString()),
                              ReusableRow(
                                  name: 'email',
                                  value:
                                      snapshot.data![index].email.toString()),
                              ReusableRow(
                                  name: 'address',
                                  value: snapshot.data![index].address!.street
                                      .toString()),
                              ReusableRow(
                                  name: 'phone',
                                  value: snapshot.data![index].phone.toString()),
                              ReusableRow(name: 'website', value: snapshot.data![index].website
                                  .toString())
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({required this.name, required this.value});

  String name;
  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
