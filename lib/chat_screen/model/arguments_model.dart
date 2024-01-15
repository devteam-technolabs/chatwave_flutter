import 'dart:io';

class ChatArgumnets {
  String? docId;
  bool? isCreated;
  String? recieverId;
  String? recieverName;
  String? profileImage;
  String? fcmToken;

  ChatArgumnets(
      { this.docId,
       this.isCreated,
       this.fcmToken,
       this.recieverId,
       this.profileImage,
       this.recieverName});
}

class MyStoryArguments {
  String? name;
  String? profileUrl;
  String? storyUrl;

  MyStoryArguments(
      { this.name,
        this.profileUrl,
        this.storyUrl,});
}


class GroupChatArgumnets {
  String? docId;
  String? groupProfileImage;
  String? groupName;
  bool? isCreated;
  List? recieverUid;
  List? recieverName;
  List? fcmToken;

  GroupChatArgumnets(
      { this.docId,
        this.isCreated,
        this.fcmToken,
        this.recieverUid,
        this.groupProfileImage,
        this.groupName,
        this.recieverName});
}

class GroupProfileArguments {
  String? groupProfileImage;
  String? groupName;
  String? groupCreatedBy;
  List? recieverUid;

  GroupProfileArguments(
      {
        this.recieverUid,
        this.groupProfileImage,
        this.groupCreatedBy,
        this.groupName,});
}




