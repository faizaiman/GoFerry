import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';

class FerryBuilder extends StatelessWidget {
  const FerryBuilder({
    Key? key,
    required this.future,
    required this.onView,
  }) : super(key: key);
  final Future<List<FerryTicket>> future;

  final Function(FerryTicket) onView;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FerryTicket>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final ferryTicket = snapshot.data![index];
                return _buildFerryTicketCard(ferryTicket, context);
              },
            ),
          );
        });
  }

  Widget _buildFerryTicketCard(FerryTicket ferryTicket, BuildContext context) {
    return GestureDetector(
      onTap: () => onView(ferryTicket),
      child: Container(
        height: 100,
        child: Card(
          color: Colors.blueAccent[100],
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.anchor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.0),
                      Text(
                        ferryTicket.dest_route,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text("Departure Date:"),
                          Text(ferryTicket.depart_date.toString()),
                        ],
                      ),
                    ],
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
