class LoginModel {
  bool? status;
  String? message;
   UserData? data;
  /*
  LoginModel({required this.status, required this.message,});

   */
LoginModel.fromJson(Map<String,dynamic> json){
  status=json['status'];
  message=json['message'];
  data=json['data'] != null ? UserData.fromJson(json['data']) : null;
}
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  int? points;
  int? credits;
  String? token;
/*
  UserData(
      {required this.image,
        required this.email,
        required this.id,
        required this.name,
        required this.phone,
        required this.token,
        required this.credits,
        required this.points,
      });

 */
  UserData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    token=json['token'];
    credits=json['credits'];
    points=json['points'];
  }
}