import 'dart:developer';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/calls_screen/controller/call_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/chat_screen/model/lastChat_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewCallScreen extends StatelessWidget {
   NewCallScreen({super.key});

  var controller = Get.isRegistered<CallController>()
      ? Get.find<CallController>()
      : Get.put(CallController());

   final firestore = FirebaseFirestore.instance;
   final _auth = FirebaseAuth.instance;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
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
                     StringConstants.kNewCall,
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.w600,
                       fontSize: 18.sp,
                     ),
                   ),
                   SizedBox(
                     width: 0.1.sw,
                   ),
                 ],
               ),
             ),
           ),

           ///------screen ui
           Padding(
             padding: const EdgeInsets.only(bottom: 40),
             child: Column(
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
                         borderRadius:  BorderRadius.circular(20),
                         color: ColorConstants.cFFFFFF,
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               space20(),
                               Text(
                                 StringConstants.kContacts,
                                 style: TextStyle(
                                   color: ColorConstants.c1C2439,
                                   fontSize: 16.sp,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                               space20(),
                               ScrollConfiguration(
                                 behavior: NoGlowHelper(),
                                 child: StreamBuilder(
                                     stream: firestore
                                         .collection('User')
                                         .where('uid',
                                         isNotEqualTo: _auth.currentUser!.uid)
                                         .snapshots(),
                                     builder: (context, snapshot) {
                                       if (snapshot.hasData) {
                                         var querySnapShot = snapshot.data;
                                         return ListView.separated(
                                           shrinkWrap: true,
                                           padding: EdgeInsets.zero
                                               .copyWith(bottom: 30),
                                           itemCount: querySnapShot!.docs.length,
                                           itemBuilder:
                                               (BuildContext context, int index) {
                                             UserModel userModel =
                                             UserModel.fromJson(querySnapShot
                                                 .docs[index]
                                                 .data());
                                             return Padding(
                                               padding:
                                               const EdgeInsets.symmetric(
                                                   vertical: 5),
                                               child: Row(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   InkWell(
                                                     splashFactory:
                                                     NoSplash.splashFactory,
                                                     onTap: () async {

                                                       ///----making last chat list
                                                       List <LastChat> lastChatList = [];
                                                       var response1 = await firestore.collection('Chat').where('uid',arrayContains: _auth.currentUser!.uid).get();
                                                       for(var u in response1.docs){
                                                         lastChatList.add(LastChat.fromJson(u.data()));
                                                       }

                                                       int search =  lastChatList.indexWhere((element){
                                                         return  element.uid!.contains(userModel.uid);
                                                       });
                                                       log("found ${search}");

                                                       if (search != -1) {
                                                         log("found ${response1.docs[search].id}");
                                                         Get.toNamed(chatMessagingScreen,
                                                             arguments: ChatArgumnets(
                                                               docId: response1.docs[search].id,
                                                               fcmToken: userModel.fcmToken,
                                                               recieverId: userModel.uid
                                                                   .toString(),
                                                               profileImage: userModel
                                                                   .profileImageUrl
                                                                   .toString(),
                                                               recieverName: userModel
                                                                   .name
                                                                   .toString(),
                                                               isCreated: true,
                                                             ));
                                                       } else {
                                                         Get.toNamed(chatMessagingScreen,
                                                             arguments: ChatArgumnets(
                                                               recieverId: userModel.uid.toString(),
                                                               fcmToken: userModel.fcmToken,
                                                               profileImage: userModel.profileImageUrl.toString(),
                                                               recieverName: userModel.name.toString(), isCreated: false,
                                                             ));
                                                       }
                                                     },
                                                     child: Row(
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
                                                               image: NetworkImage(
                                                                   userModel
                                                                       .profileImageUrl
                                                                       .toString()),
                                                               fit: BoxFit.fill,
                                                             ),
                                                           ),
                                                         ),
                                                         const SizedBox(
                                                           width: 10,
                                                         ),
                                                         Column(
                                                           mainAxisAlignment:
                                                           MainAxisAlignment
                                                               .spaceBetween,
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment
                                                               .start,
                                                           children: [
                                                             Text(
                                                               userModel.name
                                                                   .toString(),
                                                               style: TextStyle(
                                                                   color:
                                                                   ColorConstants
                                                                       .c1C2439,
                                                                   fontWeight:
                                                                   FontWeight
                                                                       .w500,
                                                                   fontSize:
                                                                   12.sp),
                                                             ),
                                                             space05(),
                                                             Text(
                                                               userModel.aboutMe
                                                                   .toString(),
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
                                                       ],
                                                     ),
                                                   ),

                                                   Container(
                                                     width: 0.22.sw,
                                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                                     decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(10),
                                                       color: ColorConstants.c1C2439.withOpacity(0.06),
                                                     ),
                                                     child: IntrinsicHeight(
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           InkWell(
                                                             splashFactory: NoSplash.splashFactory,
                                                             onTap: () async {
                                                               final Uri launchUri = Uri(
                                                                   scheme: 'tel',
                                                                   path: userModel.phoneNumber,
                                                                 );
                                                                 await launchUrl(launchUri);
                                                             },
                                                             child: Image.asset(
                                                               Assets.imagesChatCall,
                                                               height: 16,
                                                               width: 16,
                                                               fit: BoxFit.fill,
                                                               color: ColorConstants.c1C2439,
                                                             ),
                                                           ),
                                                            VerticalDivider(
                                                             color: ColorConstants.c1C2439.withOpacity(0.15),
                                                             width: 1,
                                                           ),
                                                           InkWell(
                                                             splashFactory: NoSplash.splashFactory,
                                                             onTap: () {},
                                                             child: Image.asset(
                                                               Assets.imagesVideoCallIcon,
                                                               height: 14,
                                                               width: 19,
                                                               fit: BoxFit.fill,
                                                               color: ColorConstants.c1F61E8,
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             );
                                           },
                                           separatorBuilder:
                                               (BuildContext context, int index) {
                                             return const Divider();
                                           },
                                         );
                                       } else {
                                         return const Center(
                                           child: CircularProgressIndicator(),
                                         );
                                       }
                                     }),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ),
         ],
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
