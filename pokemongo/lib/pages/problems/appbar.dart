import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/chatbot/chatbot.dart';
import 'package:pokemongo/controller/upload_post_controller.dart';
import 'package:pokemongo/profile/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key});

  UploadPostController uploadPostController = Get.put(UploadPostController());

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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Text(uploadPostController.coins.value.toString(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.catching_pokemon_rounded,
                        color: Colors.redAccent, size: 15),
                  ],
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.to(() => ProfileScreen(),
                    transition: Transition.rightToLeft),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
