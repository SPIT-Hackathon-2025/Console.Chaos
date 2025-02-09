import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/widgets/lost_and_found_post.dart';

class ChatBotPageController extends GetxController {
  var chatList = <ChatMessage>[].obs;
  var showGuide = false.obs;
  var messageController = TextEditingController();

  Future<void> getBotResponse(String message) async {
    final response = await apiService.post("/aiRoutes", body: {"text": message});
    chatList.add(ChatMessage(message: message, isUser: true));

    if (response.containsKey("post")) {
      var post = response["post"][0];
      chatList.add(ChatMessage(
        message: "", // Ensures widget appears first
        isUser: false,
        widget: LostFoundItem(
          imageUrl: post["imgUrl"] ?? "",
          username: post["user"] ?? "Unknown User",
          location: post["address"] ?? "Unknown Location",
          timeFound: post["createdAt"] ?? "Unknown Time",
          description: post["description"] ?? "No description provided.",
          onClaim: () => {},
          isOwner: false,
          isClaimed: false.obs,
        ),
      ));

      chatList.add(ChatMessage(
        message: response["info"] ?? "Here is some relevant information.",
        isUser: false,
      ));
    } else {
      chatList.add(ChatMessage(
        message: response["info"] ?? "No relevant information found.",
        isUser: false,
      ));
    }
    messageController.clear();
  }
}

class ChatMessage {
  final Widget widget;
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser, this.widget = const SizedBox.shrink()});
}

class ChatBotPage extends StatelessWidget {
  final ChatBotPageController botController = Get.put(ChatBotPageController());

  ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgcolor,
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => botController.chatList.isEmpty && !botController.showGuide.isTrue
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Psyduck",
                              style: TextStyle(
                                color: Colors.grey[700]!,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: botController.chatList.length,
                        itemBuilder: (context, index) {
                          final message = botController.chatList[index];
                          final isUser = message.isUser;
                          
                          return Column(
                            crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (message.widget is! SizedBox) message.widget,
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  isUser ? 64.0 : 16.0,
                                  4,
                                  isUser ? 16.0 : 64.0,
                                  4,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: isUser ? Colors.grey[300] : Colors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: isUser ? Colors.black87 : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        enableSuggestions: true,
                        maxLines: null,
                        controller: botController.messageController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ask me a question...",
                          hintStyle: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      botController.showGuide.value = false;
                      if (botController.messageController.text.isNotEmpty) {
                        botController.getBotResponse(
                          botController.messageController.text.trim(),
                        );
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}