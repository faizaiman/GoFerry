// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:goferry/services/ferryservice.dart';

class order_page extends StatefulWidget {
  const order_page({Key? key, this.ferryTicket}) : super(key: key);
  final FerryTicket? ferryTicket;
  @override
  _OderPageState createState() {
    return _OderPageState();
  }
}

enum JourneyEnum { OneWay, Return }

class _OderPageState extends State<order_page> {
  final DatabaseService _databaseService = DatabaseService();
  static TextEditingController _getDate = new TextEditingController();
  // static String _getDate = " ";
  // DateTime _dateController = DateTime.parse(_getDate);

  int _depatureController = 0;
  int _destinationController = 0;
  final TextEditingController _journeyController = TextEditingController();

  Future<void> _onSave() async {
    final dates = DateTime.parse(_getDate.text);
    final depature = _selectedValDepature;
    final destination = _selectedValDestination;
    final journeys = _journey.name;

    await _databaseService.insertFerryTicket(FerryTicket(
        depart_date: dates,
        journey: journeys,
        depart_route: depature,
        dest_route: destination));
    Navigator.pop(context);
  }

  _OderPageState() {
    _selectedValDestination = _destination[0];
    _selectedValDepature = _depature[0];
  }

  final _formKey = GlobalKey<FormState>();

  final _destination = [
    " Please select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];
  final _depature = [
    " Please select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];
  String _selectedValDestination = "";
  String _selectedValDepature = "";
  JourneyEnum _journey = JourneyEnum.OneWay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Container(
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
          key: _formKey,
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
                      controller: _getDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: "Date",
                      onChanged: (val) => print(val),
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      onSaved: (val) => print(val),
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
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
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
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
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
                          title: Text("One Way"),
                          onChanged: (value) {
                            setState(() {
                              _journey = value as JourneyEnum;
                            });
                          },
                        ),
                        RadioListTile<JourneyEnum>(
                          //   controller: ,
                          value: JourneyEnum.Return,
                          groupValue: _journey,
                          title: Text("Return"),
                          onChanged: (val) {
                            setState(() {
                              _journey = val as JourneyEnum;
                            });
                          },
                        ),
                        ElevatedButton(
                          onPressed: _onSave,
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
