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
  //final int ANIMATED_BODY_MS = 500;
  final DatabaseService _databaseService = DatabaseService();
  bool showBody = false;

  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        showBody = true;
      });
    });
  }

  Future<void> _onSave() async {
    // final depature = _departure[_selectedDeparture];
    // final destination = _destination[_selectedDestination];
    // final journeys = _journey[_selectedJourney];
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
            "Confirmation",
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
      body: animatedBody(),
      floatingActionButton: getButtons(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  getBody() {
    return ListView(
      children: [
        //getStack(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //child: getInfoHead()
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Booking Details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GoogleFonts.lato()',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text('Departure Date ${(widget.depart_date).toString()}'),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Destination: ${(widget.dest_route)}',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Departure: ${(widget.depart_route).toString()}',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Journey: ${(widget.journey).toString()}',
              ),
            ),
          ],
        )
      ],
    );
  } //end of getBody

  getButtons() {
    return ElevatedButton(
      onPressed: () => _onSave(),
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF78ffd6)),
      child: const Text(
        "Confirm Booking",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  animatedBody() {
    return AnimatedCrossFade(
      firstChild: getBody(),
      secondChild: Container(),
      crossFadeState:
          showBody ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
    );
  }
}
