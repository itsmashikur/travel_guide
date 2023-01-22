import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.id});

  final int id;

  //Data that will receive from api
  final dynamic dataReceived = [
    {
      "id": 1,
      "image": "http://mashikur.dev.alpha.net.bd/api-data/?image=plane.jpg",
      "title": "Airplane",
      "details":
          "Airplane, also called aeroplane or plane, any of a class of fixed-wing aircraft that is heavier than air, propelled by a screw propeller or a high-velocity jet, and supported by the dynamic reaction of the air against its wings. For an account of the development of the airplane and the advent of civil aviation see history of flight.The essential components of an airplane are a wing system to sustain it in flight, tail surfaces to stabilize the wings, movable surfaces to control the attitude of the plane in flight, and a power plant to provide the thrust necessary to push the vehicle through the air. Provision must be made to support the plane when it is at rest on the ground and during takeoff and landing. Most planes feature an enclosed body (fuselage) to house the crew, passengers, and cargo; the cockpit is the area from which the pilot operates the controls and instruments to fly the plane."
    },
    {
      "id": 2,
      "image": "http://mashikur.dev.alpha.net.bd/api-data/?image=train.jpg",
      "title": "Train",
      "details":
          "A passenger train is used to transport people along a railroad line. These trains may consist of unpowered passenger railroad cars (also known as coaches or carriages) hauled by one or more locomotives, or may be self-propelled; self propelled passenger trains are known as multiple units or railcars."
    },
    {
      "id": 3,
      "image": "http://mashikur.dev.alpha.net.bd/api-data/?image=bus.jpg",
      "title": "Bus",
      "details":
          "Karl Benz engineered the first motorized bus in 1895. In 1906, France, once again, became the pioneer by opening the first short motorized bus line. Those first buses were a far cry from the modern ones, offering minimal comfort to passengers."
    },
    {
      "id": 4,
      "image": "http://mashikur.dev.alpha.net.bd/api-data/?image=car.jpg",
      "title": "Car",
      "details":
          "In 1896, Benz designed and patented the first internal-combustion flat engine, called boxermotor. During the last years of the 19th century, Benz was the largest car company in the world with 572 units produced in 1899 and, because of its size, Benz & Cie., became a joint-stock company."
    }
  ];

  @override
  Widget build(BuildContext context) {
    getData(id) {
      dynamic screenData = {"status": false};

      dataReceived.forEach((data) {
        if (data['id'] == id) {
          screenData = {
            "status": true,
            "data": {
              "image": data['image'],
              "title": data['title'],
              "details": data['details'],
            }
          };
        }
      });

      return screenData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getData(id)['data']['title']),
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Image(
                  image: NetworkImage(getData(id)['data']['image']),
                  fit: BoxFit.cover,
                )),
            Text(
              getData(id)['data']['title'],
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
              getData(id)['data']['details'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
