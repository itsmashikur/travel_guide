import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'details_page.dart';

// Create List
Future<List<Item>> fetchData() async {
  var url = Uri.parse('http://mashikur.dev.alpha.net.bd/api-data/?home');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    if (json.decode(response.body)['status'] == true) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => Item.fromJson(data)).toList();
    } else {
      throw Exception('No Data Found!');
    }
  } else {
    throw Exception('Something Wnt Wrong!');
  }
}

// Item Model
class Item {
  final int id;
  final String image;
  final String title;
  final String background;
  final int icon;

  Item(
      {required this.id,
      required this.image,
      required this.title,
      required this.background,
      required this.icon});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      background: json['background'],
      icon: json['icon'],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header Row
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "http://mashikur.dev.alpha.net.bd/api-data/?image=header.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 10,
                  left: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "TRAVEL",
                        style: TextStyle(
                          color: Colors.pink[400],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "GUIDE",
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body Row
          const Expanded(
            child: GetItemFromApi(),
          ),
        ],
      ),
    );
  }
}

class GetItemFromApi extends StatefulWidget {
  const GetItemFromApi({super.key});

  @override
  State<GetItemFromApi> createState() => _GetItemFromApiState();
}

class _GetItemFromApiState extends State<GetItemFromApi> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(snapshot.data!.length, (index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    print('tapped: ${snapshot.data![index].id}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(int.parse(snapshot.data![index].background)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(
                              IconData(snapshot.data![index].icon,
                                  fontFamily: 'MaterialIcons'),
                              size: 70,
                              color: Colors.white,
                            )),
                        Text(
                          snapshot.data![index].title,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const SizedBox(
          height: 100,
            child: CircularProgressIndicator(),

        );
      },
    );
  }
}
