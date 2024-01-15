import 'package:story_view/widgets/story_view.dart';

class UserModel {
  String? name;
  String? uid;
  String? phoneNumber;
  String? profileImageUrl;
  String? country;
  String? fcmToken;
  String? aboutMe;
  int? storyCount;
  bool? isMemberSelected;
  List<StoryItem> story=[];

  UserModel(
      {this.name,
        this.uid,
        this.phoneNumber,
        this.profileImageUrl,
        this.country,
        this.fcmToken,
        this.storyCount,
        this.isMemberSelected,
        this.aboutMe});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    phoneNumber = json['phoneNumber'];
    profileImageUrl = json['profileImageUrl'];
    country = json['country'];
    fcmToken = json['fcmToken'];
    storyCount = json['storyCount'];
    isMemberSelected = json['isMemberSelected'];
    aboutMe = json['aboutMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImageUrl'] = this.profileImageUrl;
    data['country'] = this.country;
    data['fcmToken'] = this.fcmToken;
    data['storyCount'] = this.storyCount;
    data['isMemberSelected'] = this.isMemberSelected;
    data['aboutMe'] = this.aboutMe;
    return data;
  }
}
