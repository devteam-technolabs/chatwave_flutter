class InitialStoryModel{
  String? uid;
  String? time;
  InitialStoryModel({ this.uid,this.time});
  InitialStoryModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    time = json['Latest'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['Latest'] = this.time;
    return data;
  }
}