class UserModel{
  String? name,email,userId,userPic;
  UserModel({this.name, this.email, this.userId, this.userPic});

  UserModel.fromJson(Map<dynamic,dynamic>?map){
    if(map == null){
      return;
    }
    name=map['name'];
    email=map['email'];
    userId=map['userId'];
    userPic=map['userPic'];
  }
  toJson(){
    return{
    'userPic':userPic,
    'email':email,
    'userId':userId,
    'name':name,
    };
  }
}