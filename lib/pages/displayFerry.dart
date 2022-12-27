import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goferry/common_widgets/ferryBuilder.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/services/ferryservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goferry/pages/order.dart';
import 'package:goferry/services/Spreferences.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final DatabaseService _databaseService = DatabaseService();

<<<<<<< Updated upstream
  // Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
  //   await _databaseService.deleteFerryTicket(ferryTicket.book_id);
  //   setState(() {});
  // }
=======
  Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
    await _databaseService.deleteFerryTicket(
      ferryTicket.book_id!,
    );
    setState(() {});
  }
>>>>>>> Stashed changes

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
        body: TabBarView(
          children: [
<<<<<<< Updated upstream
            // FerryBuilder
            // (
            //   future: _databaseService.getFerryTickets(),
            //   onDelete: _onFerryTicketDelete,
            //   onEdit: (value)
            //   {
            //     Navigator.of(context).push
            //     (
            //       MaterialPageRoute
            //       (
            //         builder: (_) => BrandFormPage(ferryTicket:value),
            //         fullscreenDialog: true,
            //       ),
            //     ).then((_)=>setState((){}));
            //   }
            // ),
=======
            FerryBuilder(
                future: _databaseService
                    .getFerryTickets(Spreferences.getCurrentUserId() as int),
                onDelete: _onFerryTicketDelete,
                onEdit: (value) {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => order_page(ferryTicket: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }),
>>>>>>> Stashed changes
          ],
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => const order_page(),
                    fullscreenDialog: true,
                  ))
                  .then((_) => setState(() {}));
            },
            heroTag: 'addFerryTicket',
            child: const FaIcon(FontAwesomeIcons.plus),
          ),
          const SizedBox(height: 12.0),
        ]),
      ),
    );
  }
}
