// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/models/user.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:goferry/pages/displayFerry.dart';
import 'package:goferry/services/ferryservice.dart';

// ignore: camel_case_types
class Order_page extends StatefulWidget {
  const Order_page({Key? key, this.ferryTicket, required this.user})
      : super(key: key);
  final FerryTicket? ferryTicket;
  final User user;
  @override
  // ignore: library_private_types_in_public_api
  _OrderPageState createState() => _OrderPageState();
}

enum JourneyEnum { OneWay, Return }

class _OrderPageState extends State<Order_page> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();
  static TextEditingController _getDate = new TextEditingController();
  static TextEditingController _dateDepart = TextEditingController();
  final TextEditingController _journeyController = TextEditingController();
  final int _depatureController = 0;
  final int _destinationController = 0;

  String _selectedValDestination = _destination[0];
  String _selectedValDepature = _depature[0];

  static final _destination = [
    " Please select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];
  static final _depature = [
    " Please select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];
  JourneyEnum _journey = JourneyEnum.OneWay;

  @override
  void initState() {
    super.initState();
    if (widget.ferryTicket != null) {
      _dateDepart.text = widget.ferryTicket!.depart_date;
      _selectedValDepature = widget.ferryTicket!.depart_route;
      _selectedValDestination = widget.ferryTicket!.dest_route;
      _journeyController.text = widget.ferryTicket!.journey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: SizedBox(
            width: 40,
            child: Image.asset("assets/logo.png"),
          ),
          // ignore: prefer_const_constructors
          bottom: PreferredSize(
            child: const Text(
              "Go Ferry",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            preferredSize: Size.zero,
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.all(16),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Ticket Booking",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  //phone number input
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd MMM, yyyy',
                      controller: _dateDepart,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      icon: const Icon(Icons.event),
                      dateLabelText: "Date",
                      // ignore: avoid_print
                      onChanged: (val) => debugPrint(val),
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      // ignore: avoid_print
                      onSaved: (val) => debugPrint(val),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: _selectedValDepature,
                      items: _depature
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedValDepature = val as String;
                          debugPrint(_selectedValDepature);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Departure",
                        prefixIcon: Icon(
                          Icons.directions_ferry_outlined,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      //controller:,
                      value: _selectedValDestination,
                      items: _destination
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedValDestination = val as String;
                          debugPrint(_selectedValDestination);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Destination",
                        prefixIcon: Icon(
                          Icons.pin_drop_outlined,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Journey",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        RadioListTile<JourneyEnum>(
                          //   controller: ,
                          value: JourneyEnum.OneWay,
                          groupValue: _journey,
                          title: const Text("One Way"),
                          onChanged: (value) {
                            setState(() {
                              _journey = value as JourneyEnum;
                              debugPrint(_journey.toString());
                            });
                          },
                        ),
                        RadioListTile<JourneyEnum>(
                          //   controller: ,
                          value: JourneyEnum.Return,
                          groupValue: _journey,
                          title: const Text("Return"),
                          onChanged: (val) {
                            setState(() {
                              _journey = val as JourneyEnum;
                              debugPrint(_journey.toString());
                            });
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String depart_date = _dateDepart.text;
                              String journey = _journeyController.text;
                              String depart_route = _selectedValDepature;
                              String dest_route = _selectedValDestination;

                              FerryTicket ferryTicket = FerryTicket(
                                  depart_date: depart_date,
                                  journey: journey,
                                  depart_route: depart_route,
                                  dest_route: dest_route,
                                  user_id: widget.user.user_id!);
                              _databaseService.insertFerryTicket(
                                ferryTicket,
                              );
                            }
                          },
                          child: const Text(" Confirm Order"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
