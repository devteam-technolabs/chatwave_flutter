class LastChatGroup {
  List? uid;
  List? groupMembersName;
  List? fcmTokens;
  String? lastMsg;
  String? lastMsgTime;
  String? lastMsgBy;
  String?  lastMsgByUid;
  String? docId;
  bool? lastMsgIsImage;
  bool? lastMsgIsVideo;
  bool? lastMsgIsAudio;
  String? groupName;
  String? groupCreatedBy;
  String? groupProfileImage;

  LastChatGroup(
      {this.uid,
        this.lastMsg,
        this.lastMsgTime,
        this.lastMsgBy,
        this.lastMsgByUid,
        this.docId,
        this.lastMsgIsImage,
        this.lastMsgIsVideo,
        this.lastMsgIsAudio,
        this.groupName,
        this.groupProfileImage,
        this.groupMembersName,
        this.groupCreatedBy,
        this.fcmTokens,
      });

  LastChatGroup.fromJson(Map<String, dynamic> json) {
    uid = json['uid'].cast<String>();
    lastMsg = json['lastMsg'];
    lastMsgTime = json['lastMsgTime'];
    lastMsgBy = json['lastMsgBy'];
    lastMsgByUid = json['lastMsgByUid'];
    docId = json['docId'];
    lastMsgIsImage = json['lastMsgIsImage'];
    lastMsgIsVideo = json['lastMsgIsVideo'];
    lastMsgIsAudio = json['lastMsgIsAudio'];
    groupName = json['groupName'];
    groupProfileImage = json['groupProfileImage'];
    groupMembersName = json['groupMembersName'];
    groupCreatedBy = json['groupCreatedBy'];
    fcmTokens = json['fcmTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['lastMsg'] = this.lastMsg;
    data['lastMsgTime'] = this.lastMsgTime;
    data['lastMsgBy'] = this.lastMsgBy;
    data['lastMsgByUid'] = this.lastMsgByUid;
    data['docId'] = this.docId;
    data['lastMsgIsImage'] = this.lastMsgIsImage;
    data['lastMsgIsVideo'] = this.lastMsgIsVideo;
    data['lastMsgIsAudio'] = this.lastMsgIsAudio;
    data['groupName'] = this.groupName;
    data['groupProfileImage'] = this.groupProfileImage;
    data['groupMembersName'] = this.groupMembersName;
    data['groupCreatedBy'] = this.groupCreatedBy;
    data['fcmTokens'] = this.fcmTokens;
    return data;
  }
}
