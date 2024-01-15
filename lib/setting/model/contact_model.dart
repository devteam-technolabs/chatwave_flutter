class ContactModel{
  String image;
  String name;
  bool? isShare;
  ContactModel({
    required this.image,required this.name,required this.isShare,
});
}
class RoutModel {
  String? title;
  bool? contact;
  RoutModel({this.title, this.contact});
}