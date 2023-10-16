import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sun_c9/ui/utils/dialog_utils.dart';

import '../../../../models/app_user.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName ="login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email ="";

  String password ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Login"),
toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height:MediaQuery.of(context).size.height * .25 ,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Welcome back !",style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),
          ),
            TextFormField(
              onChanged: (text){
                email = text;
              },
              decoration: InputDecoration(
                label: Text(
                  "Email",
                )
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              onChanged: (text){
                password = text;
              },
              decoration: InputDecoration(
                  label: Text(
                    "Password",
                  ),
              ),
            ),
            SizedBox(height: 26,),
            ElevatedButton(
                onPressed: (){
                  loginFun();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                  child: Row(
                    children: [
                      Text("Login",style: TextStyle(fontSize: 18),),
                      Spacer(),
                      Icon(Icons.arrow_forward),

                    ],
                  ),
                )),
            SizedBox(height: 18,),
            InkWell(
                onTap: (
                    ){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: Text("Create account",style: TextStyle(
                  fontSize: 18,color: Colors.black45,
                ),)),
          ],
        ),),
      ),

    );
  }

  void loginFun() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser currentUser = await getUserFromFirestore(userCredential.user!.uid);


      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);


    } on FirebaseAuthException catch (error) {
      hideLoading(context);
      showErrorDialog(context, error.message ?? "Some thing went wrong");
    }
  }

 Future <AppUser> getUserFromFirestore(String id) async{
    CollectionReference <AppUser> userCollection = AppUser.collection();
   DocumentSnapshot<AppUser> documentSnapshot =  await userCollection.doc(id).get();
   return documentSnapshot.data()!;
 }
}
