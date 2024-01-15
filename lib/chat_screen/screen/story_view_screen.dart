import 'dart:async';

import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

import '../../constants/firebase_key_constants.dart';
import '../../constants/key_constants.dart';
import '../../constants/string_constants.dart';
import '../../constants/text_style_constants.dart';

class StoryViewScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final List<StoryItem> storyItems;
  final controller;
  bool? isUSer = false;

  StoryViewScreen(
      {super.key,
      required this.name,
      required this.profileImage,
      required this.storyItems,
      this.controller,
      this.isUSer});

  @override
  State<StatefulWidget> createState() {
    return _StoryViewScreenState();
  }
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  bool showPerformance = false;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.storyItems);
    return MaterialApp(
      showPerformanceOverlay: showPerformance,
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MyHomePage(
            onSetting: onSettingCallback,
            name: widget.name,
            profileImage: widget.profileImage,
            storyItems: widget.storyItems,
            controller: widget.controller,
            isUser: widget.isUSer,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback onSetting;
  final String name;
  final String profileImage;
  final List<StoryItem> storyItems;
  final controller;

  bool? isUser = false;

  MyHomePage(
      {Key? key,
      required this.onSetting,
      required this.name,
      required this.profileImage,
      required this.storyItems,
      this.controller,
      this.isUser})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0.2;
  double upperBound = 1.1;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    //Timer(const Duration(seconds: 12), () { Get.back(); });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<StoryItem> storyItems = [
    //
    //   StoryItem.pageImage(
    //       url: widget.storyUrl,
    //       controller: controller,
    //       imageFit: BoxFit.fitWidth,
    //       //shown: true,
    //       caption: widget.caption,
    //       duration: const Duration(seconds: 5)),
    //   StoryItem.pageImage(
    //       url: widget.storyUrl,
    //       controller: controller,
    //        imageFit: BoxFit.fitWidth,
    //       //shown: true,
    //       caption: widget.caption,
    //       duration: const Duration(seconds: 5)),
    // ];
    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(0.4),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Material(
                child: StoryView(
                  storyItems: widget.storyItems,
                  controller: widget.controller,
                  inline: true,
                  repeat: true,
                  onComplete: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 20),
                child: Row(
                  children: [
                    InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          Get.back();
                        },
                        child: const Image(
                          image: AssetImage(Assets.imagesStatusBack),
                          height: 25,
                          width: 25,
                          color: ColorConstants.cFFFFFF,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(widget.profileImage),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: ColorConstants.cFFFFFF),
                    ),
                    const Spacer(),
                    if (widget.isUser == true) ...[
                      InkWell(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 30, right: 10),
                                      actionsPadding:
                                          EdgeInsets.only(top: 30, bottom: 30),
                                      content: Text(
                                        'Delete Item',
                                        style:
                                            TextStyleDecoration.s20w400c1C2439,
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5)),
                                                ),
                                                child: Text(
                                                    StringConstants.kDelete,
                                                    style:
                                                        TextStyleDecoration
                                                            .s16w600cFFFFFF
                                                            .copyWith(
                                                                color: Colors
                                                                    .red)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5)),
                                                    color: ColorConstants
                                                        .cE9E9E9),
                                                child: Text(
                                                    StringConstants.kCancel,
                                                    style: TextStyleDecoration
                                                        .s16w600cFFFFFF
                                                        .copyWith(
                                                            color: ColorConstants
                                                                .c1C2439)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                    InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {},
                        child: const Image(
                          image: AssetImage(Assets.imagesStatusMoreVerticalDot),
                          height: 20,
                          width: 20,
                          color: ColorConstants.cFFFFFF,
                        )),
                  ],
                ),
              ),
            ],
          ),
          if(widget.isUser==true)...[
            SlidingUpPanelWidget(
              controlHeight: 20.0,
              anchor: 0.6,
              minimumBound: minBound,
              upperBound: upperBound,
              panelController: panelController,
              onTap: () {
                if (SlidingUpPanelStatus.expanded == panelController.status) {
                  panelController.collapse();
                } else {
                  panelController.expand();
                }
              },
              enableOnTap: true,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        color: Color(0x11000000))
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: const BoxDecoration(
                          color: ColorConstants.c1F61E8,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.menu,
                            size: 30,
                            color: ColorConstants.cFFFFFF,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                            ),
                          ),
                          Text(
                            'People seen',
                            style: TextStyle(color: ColorConstants.cFFFFFF),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                    NetworkImage(widget.profileImage),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: ColorConstants.c626B84),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0.5,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]

        ],
      ),
    );
  }
}
