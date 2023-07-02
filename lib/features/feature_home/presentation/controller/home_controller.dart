import 'package:flow/features/feature_home/domain/model/time_of_day.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final timeOfDay = MyTimeOfDay.morning.obs;

  @override
  void onInit() {
    super.onInit();

    final DateTime dateTime = DateTime.now();
    getGreetingsFromHour(hour: dateTime.hour);
  }

  void getGreetingsFromHour({required int hour}) {
    if (hour > 0 && hour < 12) {
      timeOfDay.value = MyTimeOfDay.morning;
    } else if (hour >= 12 && hour < 17) {
      timeOfDay.value = MyTimeOfDay.afternoon;
    } else {
      timeOfDay.value = MyTimeOfDay.evening;
    }
  }
}
