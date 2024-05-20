// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias de API',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Noticias de API'),
          titleTextStyle: TextStyle(
            color: const Color.fromARGB(255, 167, 15, 15),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: NewsList(),
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a29a2e91774040309344c199b0277874';
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body)['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 160, 185, 206),
              )),
        );
      },
    );
  }
}
