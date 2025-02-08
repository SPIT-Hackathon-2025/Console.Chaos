import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/upload_post_controller.dart';

class UploadPost extends StatelessWidget {
  final UploadPostController controller = Get.put(UploadPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              // Dropdown for selecting post type
              Row(
                children: [
                  Text("Upload",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Obx(() => DropdownButtonFormField(
                          dropdownColor: Colors.black,
                          value: controller.selectedCategory.value,
                          items: controller.categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            );
                          }).toList(),
                          onChanged: (value) => controller
                              .selectedCategory.value = value as String,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // **Dynamic Fields Based on Selected Category**
              Obx(() {
                if (controller.selectedCategory.value == 'Regular Post') {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Click here to add a description',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  );
                } else if (controller.selectedCategory.value ==
                    'Community Service Post') {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.titleController,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Click here to add a title',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            controller.timeController.text =
                                pickedTime.format(context);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: controller.timeController,
                            decoration: InputDecoration(
                              labelText: 'Click here to add a time',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (controller.selectedCategory.value ==
                    'Lost & Found Post') {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.descriptionController,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Click here to add a description',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),

              SizedBox(height: 20),

              // Capture Image Button

              // Show Image if selected
              Obx(() => controller.image.value != null
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.file(controller.image.value!,
                              height: 250, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 10),
                        Obx(() => controller.position.value != null &&
                                controller.address.value.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.address.value,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white)),
                                  SizedBox(height: 20),
                                ],
                              )
                            : SizedBox.shrink()),
                      ],
                    )
                  : SizedBox.shrink()),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: controller.captureImage,
                  icon: Icon(Icons.camera_alt, color: Colors.redAccent),
                  label: Text('Attach Image',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                ),
              ),
              SizedBox(height: 70),

              // Upload Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Upload logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Upload Post',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
