import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:machinetests/details.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<dynamic> request() async {
    String Url = "https://dummyapi.io/data/v1/user?limit=10";
    var responce = await get(Uri.parse(Url),
        headers: {'app-id': "61dbf9b1d7efe0f95bc1e1a6"});
 
    var msg = jsonDecode(responce.body)["data"];
    print(msg[0]["firstName"]);
   
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List',style: TextStyle(color: Colors.black),),
      ),
      body: FutureBuilder(
          future: request(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const  Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (cnxt) {
                              return DetailsUsers(id: snapshot.data[index]['id']);
                            })),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data[index]['picture']),
                        ),
                        title: Text(
                          snapshot.data[index]["firstName"],
                        ),
                        subtitle: Text(
                          snapshot.data[index]["lastName"],
                        )),
                  );
                },
              );
            } else {
              return const  Center(child: Text("Somethig Went Wrong"));
            }
          }),
    );
  }
}
