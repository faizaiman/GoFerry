import 'package: flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goferry/common_widgets/ferryBuilder.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/services/ferryservice.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final DatabaseService _databaseService = DatabaseService();
  ////////
  ////////
  ///////
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ferry Tickets'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Ferry Tickets'),
              ),
            ],
          ),
        ),
        body: TabBarView
        (
          children:
          [
            FerryBuilder(future: _databaseService.getFerryTickets(), onDelete: , onEdit: onEdit)
          ]
        )
      ),
    );
  }
}
