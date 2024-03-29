import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goferry/pages/order.dart';
import 'package:goferry/pages/displayFerry.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:goferry/services/ferryservice.dart';
import 'package:goferry/services/Spreferences.dart';

import '../common_widgets/bottom_navigation.dart';
import '../models/ferryticket.dart';
import '../models/user.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage(
      {Key? key,
      this.ferryTicket,
      this.book_id,
      required this.user,
      required this.depart_date,
      required this.journey,
      required this.depart_route,
      required this.dest_route})
      : super(key: key);

  final String depart_date;
  final String journey;
  final String depart_route;
  final String dest_route;
  final FerryTicket? ferryTicket;
  final User user;
  final int? book_id;

  @override
  _ConfirmPageState createState() {
    return _ConfirmPageState();
  }
}

class _ConfirmPageState extends State<ConfirmPage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onSave() async {
    widget.book_id == null
        ? await _databaseService.insertFerryTicket(
            FerryTicket(
                depart_date: widget.depart_date,
                journey: widget.journey,
                depart_route: widget.depart_route,
                dest_route: widget.dest_route,
                user_id: Spreferences.getCurrentUserId() as int),
          )
        : await _databaseService.editFerryTicket(
            FerryTicket(
                book_id: int.tryParse(widget.book_id.toString()),
                depart_date: widget.depart_date,
                journey: widget.journey,
                depart_route: widget.depart_route,
                dest_route: widget.dest_route,
                user_id: Spreferences.getCurrentUserId() as int),
          );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BottomNavigation(user: widget.user, currentPage: 0),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: SizedBox(
          width: 40,
          child: Image.asset('assets/logo.png'),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            "Go Ferry",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage('assets/orderimg.png'),
                height: size.height * 0.25,
              ),
              const SizedBox(height: 5),
              Text(
                "Booking Confirmation ",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Destination: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.dest_route,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Departure: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.depart_route,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Departure Date: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.depart_date.toString(),
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Journey Type: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.journey,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 100, height: 100),
                  ElevatedButton(
                    onPressed: () => _onSave(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 98, 173, 101)),
                    child: const Text(
                      "Confirm Booking",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
