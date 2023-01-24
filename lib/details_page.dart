import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.id});

  final int id;

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(Uri.parse(
        'http://mashikur.dev.alpha.net.bd/api-data/?details=${widget.id}'));
    data = json.decode(response.body)['data'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: Text(data['title']),
              backgroundColor: Color(int.parse(data['background'])),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: NetworkImage(data['image']),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text(
                      data['title'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        )),
                    Text(
                      data['details'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
