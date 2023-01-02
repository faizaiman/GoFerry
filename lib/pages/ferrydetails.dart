import 'package:flutter/material.dart';
import '../models/ferryticket.dart';
import '../models/user.dart';
import '../pages/order.dart';
import 'package:goferry/services/ferryservice.dart';
import '../common_widgets/bottom_navigation.dart';

class ferryDetails extends StatefulWidget {
  const ferryDetails({
    Key? key,
    this.ferryTicket,
    required this.user,
  }) : super(key: key);

  final FerryTicket? ferryTicket;
  final User user;

  @override
  _ferryDetailsState createState() {
    return _ferryDetailsState();
  }
}

class _ferryDetailsState extends State<ferryDetails> {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
    await _databaseService.deleteFerryTicket(
      ferryTicket.book_id!,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BottomNavigation(user: widget.user, currentPage: 0),
      ),
      (route) => false,
    );
    ;
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
                image: AssetImage('assets/ferry.png'),
                height: size.height * 0.25,
              ),
              const SizedBox(height: 5),
              Text(
                "Ticket Booking Details",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
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
                          const SizedBox(width: 240),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => order_page(
                                            user: widget.user,
                                            ferryTicket: widget.ferryTicket!,
                                          ),
                                      fullscreenDialog: true))
                                  .then((_) => setState(
                                        () {},
                                      ));
                            },
                            child: const Icon(Icons.edit, color: Colors.black),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Destination: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.ferryTicket!.dest_route,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Departure: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.ferryTicket!.depart_route,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Departure Date: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.ferryTicket!.depart_date,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Journey Type: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.ferryTicket!.journey,
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
                    onPressed: () => _onFerryTicketDelete(widget.ferryTicket!),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 236, 56, 71)),
                    child: const Text(
                      "Cancel Booking",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
