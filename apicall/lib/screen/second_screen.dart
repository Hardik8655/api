import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../Models/Photos.dart';

// code for GET API Calling

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Photos> photosList = [];

  Future<List<Photos>> getphotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  //  List<Photos> photosList = [];
  //
  // //  Code for auto gendered model
  //
  // Future<List<Photos>> getPhotos() async {
  //   final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  //   var data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200){
  //     photosList.clear();
  //     for(Map i in data){
  //       photosList.add(Photos.fromJson(i));
  //     }
  //     return photosList;
  //   } else{
  //     return photosList;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Two Api call"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getphotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          subtitle:
                              Text(snapshot.data![index].title.toString()),
                          title:
                              Text("Id:" + snapshot.data![index].id.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title;
  String url;
  int id;

  Photos({required this.title, required this.url, required this.id});

}
