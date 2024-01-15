import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/setting/controller/my_contact_controller.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/setting/model/contact_model.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import '../../utils/helping_widgets.dart';

class MyContactScreen extends StatelessWidget {
  MyContactScreen({Key? key}) : super(key: key);
  var controller = Get.put(MyContactController());
  RoutModel routModel = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyContactController>(
        init: MyContactController(),
        builder: (value) => Stack(
          children: [
            ///------top heading
            Container(
              height: 0.140.sh,
              width: 1.sw,
              color: ColorConstants.c1F61E8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(context: context),
                    Text(
                    routModel.title??"",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///------screen ui
            Column(
              children: [
                Container(
                  height: 0.065.sh,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(top: 95),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: _searchBar(
                      textEditController: controller.searchController,
                      textInputType: TextInputType.text,
                      icon: Assets.imagesSearchIcon,
                      focusNode: FocusNode(),
                      filledColor: ColorConstants.cFFFFFF,
                      hint: StringConstants.kSearch,
                      maxLines: 1),
                ),
                space30(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 1.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 1),
                              blurRadius: 0.1,
                              spreadRadius: 0.1,
                            ), //BoxShadow
                          ]),
                      child: Material(
                        elevation: 5,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: ColorConstants.cFFFFFF,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Expanded(
                            child: Column(
                              children: [
                                space20(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Contacts",
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "4 selected",
                                      style: TextStyle(
                                        color: ColorConstants.c626B84,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                space10(),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: NoGlowHelper(),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.zero.copyWith(bottom: 30),
                                      itemCount: controller.contactModel.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                controller
                                                                    .contactModel[
                                                                        index]
                                                                    .image),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .contactModel[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: ColorConstants
                                                                      .c1C2439,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      12.sp),
                                                            ),
                                                            space05(),
                                                            Text(
                                                              "Once you stop trying, you fail.",
                                                              style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color:
                                                                    ColorConstants
                                                                        .c626B84,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10.sp,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (controller
                                                            .contactModel[index]
                                                            .isShare ==
                                                        false) {
                                                      controller
                                                          .contactModel[index]
                                                          .isShare = true;
                                                    } else {
                                                      controller
                                                          .contactModel[index]
                                                          .isShare = false;
                                                    }
                                                    controller.update();
                                                  },
                                                  child: Image(
                                                    image: controller
                                                                .contactModel[
                                                                    index]
                                                                .isShare ==
                                                            false
                                                        ? const AssetImage(
                                                            Assets
                                                                .imagesCheckBox)
                                                        : const AssetImage(Assets
                                                            .imagesFilledCheckBox),
                                                    fit: BoxFit.fill,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _searchBar(
      {required TextEditingController textEditController,
      required TextInputType textInputType,
      required String? icon,
      required FocusNode focusNode,
      required Color? filledColor,
      required String? hint,
      required int maxLines}) {
    return Material(
      elevation: 4,
      color: ColorConstants.cFFFFFF,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: TextFormField(
          focusNode: focusNode,
          controller: textEditController,
          keyboardType: textInputType,
          maxLines: maxLines,
          style: const TextStyle(
              color: ColorConstants.c1C2439,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                  .copyWith(bottom: 5),
              child: Image(
                image: AssetImage(icon!),
                height: 18,
                width: 18,
                color: ColorConstants.cA5C0F6,
                // fit: BoxFit.fill,
              ),
            ),
            filled: true,
            counterText: '',
            border: InputBorder.none,
            hintText: hint,
            fillColor: filledColor ?? ColorConstants.cECF4FF,
            hintStyle: const TextStyle(
                color: ColorConstants.cA5C0F6,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          ),
        ),
      ),
    );
  }
}
