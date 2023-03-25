import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

class DetailsUsers extends StatefulWidget {
  final id;
  DetailsUsers({super.key, required this.id});

  @override
  State<DetailsUsers> createState() => _DetailsUsersState();
}

class _DetailsUsersState extends State<DetailsUsers> {
  Future<dynamic> deatils() async {
    String Url = "https://dummyapi.io/data/v1/user/${widget.id}";
    var responce = await get(Uri.parse(Url),
        headers: {'app-id': "61dbf9b1d7efe0f95bc1e1a6"});

    var msg = jsonDecode(responce.body);
    print(msg["firstName"]);

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text(
            "User details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: deatils(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        image: NetworkImage(snapshot.data['picture']),
                      ),
                    ),
                    Text(snapshot.data['firstName']),
                    Text(snapshot.data['lastName']),
                    Text(snapshot.data['email']),
                    Text(snapshot.data['dateOfBirth']),
                    Text(snapshot.data['phone']),
                    Text(snapshot.data['gender']),
                    Text(snapshot.data['location']['street']),
                    Text(snapshot.data['location']['city']),
                    Text(snapshot.data['location']['state']),
                  ],
                );
              } else {
                return const Center(child: Text("Something Went Wrong"));
              }
            }));
  }
}
