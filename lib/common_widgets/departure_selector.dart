import 'package:flutter/material.dart';

class departureSelector extends StatelessWidget {
  const departureSelector({
    Key? key,
    required this.selectedIndex,
    required this.onChanged,
    required this.departure,
  }) : super(key: key);

  final List<String> departure;
  final int selectedIndex;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Departure Route',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: departure.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onChanged(index),
                child: Container(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 3.0,
                      color:
                          selectedIndex == index ? Colors.teal : Colors.black,
                    ),
                  ),
                  child: Text(departure[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
