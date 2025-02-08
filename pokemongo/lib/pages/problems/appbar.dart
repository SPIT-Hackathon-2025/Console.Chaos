import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/profile/profile_screen.dart';

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
          GestureDetector(
            onTap: () => Get.to(() => ProfileScreen(), transition: Transition.rightToLeft),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
        ],
      ),
    );
  }
}
