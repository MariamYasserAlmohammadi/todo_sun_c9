import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
static const collectionName ="users";
static AppUser? currentUser ;
  late String id;
  late String email;
  late String userName;

  AppUser({required this.id,
    required this.userName,
    required this.email});

  AppUser.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    userName = json["userName"];
  }

  Map<String,dynamic> toJson(){
   return{
     "id":id,
     "email":email,
     "userName":userName,
   };
  }

  static CollectionReference<AppUser> collection (){
    return FirebaseFirestore.instance.collection(AppUser.collectionName)
        .withConverter<AppUser>(
        fromFirestore: (snapShot, _) {
          //بحول json ل object
          return AppUser.fromJson(snapShot.data()!);
        },
        toFirestore: (user, _) {
          return user.toJson();
        });
  }
}
