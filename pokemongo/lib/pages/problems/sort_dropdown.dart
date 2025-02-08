import 'package:flutter/material.dart';
import 'package:pokemongo/themes.dart';

class SortDropDown extends StatelessWidget {
  const SortDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String>(
          hint: Text("Upvotes", style: TextStyle(color: Colors.grey)),
          items: ["Low to High", "High to Low"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.grey)),
            );
          }).toList(),
          onChanged: (_) {},
          dropdownColor: bgcolor,
        ),
        DropdownButton<String>(
          hint: Text("Highest Views", style: TextStyle(color: Colors.grey)),
          items: ["Low to High", "High to Low"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.grey)),
            );
          }).toList(),
          onChanged: (_) {},
          dropdownColor: bgcolor,
        ),
        DropdownButton<String>(
            hint: Text("Location", style: TextStyle(color: Colors.grey)),
            items: ["Nearby", "Far"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.grey)),
              );
            }).toList(),
            onChanged: (_) {},
            dropdownColor: bgcolor),
      ],
    );
  }
}
