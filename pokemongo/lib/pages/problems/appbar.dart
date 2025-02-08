import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'PokemonGo',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.chat_bubble_outlined,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
