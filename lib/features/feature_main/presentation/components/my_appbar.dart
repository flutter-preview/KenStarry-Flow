import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/core/utils/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/domain/models/player_states.dart';
import '../../../../core/presentation/components/show_toast.dart';
import '../../../../core/utils/extensions/color_extensions.dart';

SliverAppBar myAppBar({required FToast toast}) {

  final CoreController controller = Get.find();
  final PlayerController playerController = Get.find<PlayerController>();

  return SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        statusBarIconBrightness:
        controller.brightness.value == Brightness.dark
            ? Brightness.light
            : Brightness.dark),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.sort_rounded,
            color: Theme.of(Get.context!).iconTheme.color,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Theme.of(Get.context!).iconTheme.color,
          )),
    ],
    expandedHeight: 120,
    floating: false,
    pinned: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      background: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //  shuffle songs
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  //  shuffle songs
                  playerController.shuffle();

                  if (playerController.isShuffleModeEnabled.value) {
                    showToast(
                        toast: toast,
                        iconData: Icons.shuffle_rounded,
                        msg: "Shuffle on");
                  } else {
                    showToast(
                        toast: toast,
                        iconData: Icons.shuffle_rounded,
                        msg: "Shuffle off");
                  }
                },
                child: Obx(
                      () => Ink(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color:
                        playerController.isShuffleModeEnabled.value
                            ? Theme.of(Get.context!).primaryColor
                            : Theme.of(Get.context!).primaryColorDark,
                        borderRadius: BorderRadius.circular(50)),
                    child: playerController.isShuffleModeEnabled.value
                        ? Icon(
                      Icons.shuffle,
                      size: 16,
                      color: getTextColorForBackground(
                          Theme.of(Get.context!).primaryColor),
                    )
                        : Icon(
                      Icons.shuffle,
                      size: 16,
                      color: Theme.of(Get.context!).iconTheme.color,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              //  play button
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  //  open library options
                },
                child: Ink(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColorDark,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Theme.of(Get.context!).primaryColor,
                      size: 32,
                    ))
              ),
            ],
          ),
        ),
      ),
      title: Text(
        "Songs",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: false,
      collapseMode: CollapseMode.parallax,
    ),
  );
}
