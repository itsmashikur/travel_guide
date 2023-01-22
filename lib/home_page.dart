import 'package:flutter/material.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    //Data that will receive from api
    final dataReceived = [
      {
        "id": 1,
        "icon": Icons.airplanemode_active,
        "color": Colors.blue,
        "title": "Airplane",
      },
      {
        "id": 2,
        "icon": Icons.train,
        "color": Colors.purple,
        "title": "Train",
      },
      {
        "id": 3,
        "icon": Icons.directions_bus,
        "color": Colors.orange,
        "title": "Bus",
      },
      {
        "id": 4,
        "icon": Icons.directions_car,
        "color": Colors.green,
        "title": "Car",
      }
    ];

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
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(25),
                color: Colors.grey[100],
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(dataReceived.length, (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  id: dataReceived[index]['id'] as int),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: dataReceived[index]['color'] as Color,
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
                                    dataReceived[index]['icon'] as IconData,
                                    size: 70,
                                    color: Colors.white,
                                  )),
                              Text(
                                dataReceived[index]['title'] as String,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )),
          ),
        ],
      ),
    );
  }
}
