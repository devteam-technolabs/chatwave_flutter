class CurrentChatGroup {
  String? message;
  String? sendBy;
  String? dateTime;
  String? sendByUid;
  bool? isImage;
  bool? isVideo;
  bool? isAudio;

  CurrentChatGroup(
      {this.message,
        this.sendBy,
        this.dateTime,
        this.sendByUid,
        this.isImage,
        this.isVideo,
        this.isAudio});

  CurrentChatGroup.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sendBy = json['sendBy'];
    dateTime = json['dateTime'];
    sendByUid = json['sendByUid'];
    isImage = json['isImage'];
    isVideo = json['isVideo'];
    isAudio = json['isAudio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    data['sendBy'] = this.sendBy;
    data['dateTime'] = this.dateTime;
    data['sendByUid'] = this.sendByUid;
    data['isImage'] = this.isImage;
    data['isVideo'] = this.isVideo;
    data['isAudio'] = this.isAudio;
    return data;
  }
}
