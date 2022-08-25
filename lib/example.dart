import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Example_two extends StatefulWidget {
  const Example_two({Key? key}) : super(key: key);

  @override
  _Example_twoState createState() => _Example_twoState();
}

List<Photos> photolist = [];

Future<List<Photos>> getPhotosapi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data = jsonDecode(response.body.toString());


  if (response.statusCode == 200) {
    for (Map i in data) {
      Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
      photolist.add(photos);
    }
    return photolist;
  } else {
    return photolist;
  }
}

class _Example_twoState extends State<Example_two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PhotoApi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotosapi(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                    itemCount: photolist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),

                        ),
                        subtitle: Text(
                          snapshot.data![index].title.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        title: Text(
                          'Notes id ' + snapshot.data![index].id.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class Photos {
  Photos({required this.title, required this.url, required this.id});
  String title;
  String url;
  int id;
}
