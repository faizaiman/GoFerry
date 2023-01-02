import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/pages/confirmPage.dart';
import 'package:goferry/services/ferryservice.dart';
import 'package:intl/intl.dart';
import 'package:goferry/services/Spreferences.dart';
import 'package:goferry/common_widgets/journeySelector.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/common_widgets/bottom_navigation.dart';

class order_page extends StatefulWidget {
  const order_page({
    Key? key,
    this.ferryTicket,
    required this.user,
  }) : super(key: key);
  final FerryTicket? ferryTicket;
  final User user;

  @override
  _OderPageState createState() => _OderPageState();
}

class _OderPageState extends State<order_page> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _getDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedDeparture = 0;
  int _selectedDestination = 0;
  int _selectedJourney = 0;

  @override
  void initState() {
    super.initState();
    if (widget.ferryTicket != null) {
      _getDate.text = widget.ferryTicket!.depart_date;
      _selectedDestination =
          _destination.indexOf(widget.ferryTicket!.dest_route);
      _selectedDeparture = _departure.indexOf(widget.ferryTicket!.depart_route);

      _selectedJourney = _journey.indexOf(widget.ferryTicket!.journey);
    }
  }

  var _journey = <String>["One Way", "Return"];
  var _departure = <String>[
    "Please Select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];

  var _destination = <String>[
    "Please Select",
    "Penang",
    "Langkawi",
    "Singapore",
    "Batam",
    "Koh Lipe"
  ];

  Future<void> _onSave() async {
    final depature = _departure[_selectedDeparture];
    final destination = _destination[_selectedDestination];
    final journeys = _journey[_selectedJourney];

    widget.ferryTicket == null
        ? await _databaseService.insertFerryTicket(
            FerryTicket(
                depart_date: _getDate.text,
                journey: journeys,
                depart_route: depature,
                dest_route: destination,
                user_id: Spreferences.getCurrentUserId() as int),
          )
        : await _databaseService.editFerryTicket(
            FerryTicket(
                book_id: widget.ferryTicket!.book_id,
                depart_date: _getDate.text,
                journey: journeys,
                depart_route: depature,
                dest_route: destination,
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
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
                  child: TextFormField(
                    controller: _getDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: " Select Departure Date"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);

                        setState(() {
                          if (_getDate.text != null) {
                            _getDate;
                          }
                          _getDate.text = formattedDate as String;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (val) => val!.isEmpty ? "Required" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    value: _destination[_selectedDestination],
                    items: _destination
                        .map((String value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDestination =
                            _destination.indexOf(value.toString());
                        print(_selectedDestination);
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
                    ),
                    validator: (val) =>
                        val == null ? 'Please Select Destination' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    value: _departure[_selectedDeparture],
                    items: _departure
                        .map((String value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDeparture =
                            _departure.indexOf(value.toString());
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                    ),
                    decoration: InputDecoration(
                      labelText: "Departure",
                      prefixIcon: Icon(
                        Icons.pin_drop_outlined,
                      ),
                    ),
                    validator: (val) =>
                        val == null ? 'Please Select Departure' : null,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: journeySelector(
                      journey: _journey,
                      selectedIndex: _selectedJourney,
                      onChanged: (Value) {
                        setState(() {
                          _selectedJourney = Value;
                        });
                      }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ConfirmPage(
                          user: widget.user,
                          depart_date: _getDate.text,
                          journey: _journey[_selectedJourney],
                          depart_route: _departure[_selectedDeparture],
                          dest_route: _destination[_selectedDestination],
                        );
                      }));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF78ffd6)),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
