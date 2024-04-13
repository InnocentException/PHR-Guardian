import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phr/controllers/app_controller.dart';
import 'package:phr/pages/home/blood_pressure_info_widget.dart';
import 'package:phr/pages/home/bmi_info_widget.dart';
import 'package:phr/pages/home/glucose_info_widget.dart';
import 'package:phr/pages/home/menu_widget.dart';
import 'package:phr/pages/profile/profile.dart';
import 'package:phr/pages/statistic/statistic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    // set orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    // load profile settings
    appController.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: GetBuilder<AppController>(
          init: AppController(),
          builder: (controller) {
            log(controller.yourImage.toString());
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (controller.yourImage.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: FileImage(
                          File(
                            controller.yourImage.toString(),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 8.0,
                ),
                Text('${controller.yourName}'),
              ],
            );
          },
        ),
        actions: [
          // IconButton(
          //   onPressed: () => Get.to(() => ProfilePage()),
          //   icon: const Icon(Icons.settings),
          // ),

          // popup menu buttons
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(value: 'share', child: Text("Share")),
              const PopupMenuItem(value: 'settings', child: Text("Profile")),
            ],
            onSelected: (value) {
              log('pop selected -> $value');
              // navigate to page
              if (value == 'share') {
                Get.to(() => const StatisticPage());
              } else {
                Get.to(() => ProfilePage());
              }
            },
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // your info
              //YourInfoWidget(),
              SizedBox(height: 8.0),

              // menu pane
              MenuWidget(),

              // bmi info
              BmiInfoWidget(),

              // blood pressure info
              BloodPressureWidget(),

              // blood glucose info
              GlucoseInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
