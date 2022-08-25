import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example_Four extends StatefulWidget {
  const Example_Four({Key? key}) : super(key: key);

  @override
  _Example_FourState createState() => _Example_FourState();
}

class _Example_FourState extends State<Example_Four> {
  var data;
  Future<void> getUserapi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserapi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  name: 'name',
                                  value: data![index]['name'].toString()),
                              ReusableRow(
                                  name: 'username',
                                  value: data![index]['username'].toString()),
                              ReusableRow(
                                  name: 'address',
                                  value: data![index]['address']['city']
                                      .toString()),
                              ReusableRow(
                                  name: 'geo',
                                  value: data![index]['address']['geo']['lat']
                                      .toString()),
                              ReusableRow(
                                  name: 'company',
                                  value:
                                      data![index]['company']['bs'].toString()),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
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
