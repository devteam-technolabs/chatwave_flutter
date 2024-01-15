class StoryModel {
  String? storyUrl;
  String? uid;
  String? name;
  String? dateTime;
  String? caption;
  String? profileImage;
   var peopleSeenUid;

  StoryModel(
      {this.storyUrl, this.uid, this.name, this.dateTime, this.peopleSeenUid,this.caption,this.profileImage});

  StoryModel.fromJson(Map<String, dynamic> json) {
    storyUrl = json['storyUrl'];
    uid = json['uid'];
    name = json['name'];
    dateTime = json['dateTime'];
    caption = json['caption'];
    profileImage = json['profileImage'];
    peopleSeenUid = json['peopleSeenUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storyUrl'] = this.storyUrl;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['dateTime'] = this.dateTime;
    data['caption'] = this.caption;
    data['profileImage'] = this.profileImage;
    data['peopleSeenUid'] = this.peopleSeenUid;
    return data;
  }
}
