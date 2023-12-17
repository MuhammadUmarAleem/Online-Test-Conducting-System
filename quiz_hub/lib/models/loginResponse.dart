class loginResponse {
  String? message;
  String? email;
  String? name;
  String? userId;
  String? rollNo;
  String? token;
  loginResponse({this.message, this.email, this.name, this.userId, this.rollNo,this.token});
  // 2 mint me aya
  loginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['email'];
    name = json['name'];
    rollNo=json['rollNo'];
    userId = json['userId'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['email'] = this.email;
    data['name'] = this.name;
    data['rollNo']=this.rollNo;
    data['userId'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
