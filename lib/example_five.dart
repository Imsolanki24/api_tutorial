import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_tutorial/Models/Product_model.dart';
import 'package:api_tutorial/Models/Data.dart';
import 'package:api_tutorial/Models/Images.dart';

class Example_Five extends StatefulWidget {
  const Example_Five({Key? key}) : super(key: key);

  @override
  _Example_FiveState createState() => _Example_FiveState();
}

class _Example_FiveState extends State<Example_Five> {
  Future<ProductModel> getProductApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/91a4f017-189b-4598-913a-f54f039ef947'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
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
            child: FutureBuilder<ProductModel>(
                future: getProductApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * .1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data[index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .data[index]
                                                    .images![position]
                                                    .url
                                                    .toString()))),
                                      );
                                    }),
                              ),
                            ],
                          );
                        });
                  } else {
                    return Text('Loading');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
