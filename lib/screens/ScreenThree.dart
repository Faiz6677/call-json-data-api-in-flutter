import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/UserModel.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  final userUrl = 'https://jsonplaceholder.typicode.com/users';
  List<UserModel> userList = [];

  Future<List<UserModel>> getUsrApi() async {
    final response = await http.get(Uri.parse(userUrl));
    final data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return throw Exception('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Three'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUsrApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'id \n ${snapshot.data![index].id.toString()}'),
                            Text('name \n ${snapshot.data![index].name}'),
                            Text(
                                'address \n ${snapshot.data![index].address!.street.toString()}'),
                            Text(
                                'address geo \n ${snapshot.data![index].address!.geo!.lat.toString()}'),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
