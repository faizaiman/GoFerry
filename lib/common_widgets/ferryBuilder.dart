import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';

class FerryBuilder extends StatelessWidget {
  const FerryBuilder(
      {Key? key,
      required this.future,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);
  final Future<List<FerryTicket>> future;
  final Function(FerryTicket) onEdit;
  final Function(FerryTicket) onDelete;

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
                final ferryTicket = snapshot.data?[index];
                return _buildFerryTicketCard(ferryTicket!, context);
              },
            ),
          );
        });
  }

  Widget _buildFerryTicketCard(FerryTicket ferryTicket, BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            alignment: Alignment.center,
            child: Text(
              ferryTicket.book_id.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ferryTicket.dest_route,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(ferryTicket.depart_date.toString()),
                const SizedBox(height: 4.0),
                const Text("Depart from:"),
                const SizedBox(height: 4.0),
                Text(ferryTicket.depart_route),
                const SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () => onEdit(ferryTicket),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.edit, color: Colors.orange[800]),
                  ),
                ),
                const SizedBox(width: 29.0),
                GestureDetector(
                  onTap: () => onDelete(ferryTicket),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.delete, color: Colors.red[800]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
