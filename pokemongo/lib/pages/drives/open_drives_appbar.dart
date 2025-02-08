import 'package:flutter/material.dart';

class OpenDriveAppBar extends StatelessWidget {
  const OpenDriveAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(

        children: [
          Text(
            'Social Events',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Connect and contribute towards the society',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
