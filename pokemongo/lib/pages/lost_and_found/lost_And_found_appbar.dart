import 'package:flutter/material.dart';

class LostAndFoundAppBar extends StatelessWidget {
  const LostAndFoundAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            'Lost and Found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Find your lost items here',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10), // Reduced height
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                      color: Colors.white), // Input text color set to white
                  decoration: InputDecoration(
                    hintText: 'Search for lost items using AI',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.black87,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
