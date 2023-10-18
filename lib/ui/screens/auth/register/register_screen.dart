import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c9/models/app_user.dart';
import 'package:todo_sun_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sun_c9/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Register"),
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .25,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Welcome back !",style: TextStyle(
              //     fontSize: 24,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),),
              // ),
              TextFormField(
                onChanged: (text) {
                  userName = text;
                },
                decoration: const InputDecoration(
                    label: Text(
                      "UserName",
                    )),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                    label: Text(
                      "Email",
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                    label: Text(
                      "Password",
                    )),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  )),

              // InkWell(
              //     onTap: (){
              //       Navigator.pushNamed(context, RegisterScreen.routeName);
              //     },
              //     child: Text("Create account",style: TextStyle(
              //       fontSize: 18,color: Colors.black45,
              //     ),)),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    try {
      // show loading
      showLoading(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      AppUser newUser = AppUser(id: userCredential.user!.uid, userName: userName, email: email);

      await registerUserInFirestore(newUser);
      AppUser.currentUser = newUser;
      // hide loading
      hideLoading(context);

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (error) {
      hideLoading(context);
      showErrorDialog(context, error.message ?? "Some thing went wrong");
    }
  }

  Future registerUserInFirestore(AppUser user) async{
    CollectionReference <AppUser> userCollectionRef = AppUser.collection();
   await userCollectionRef.doc(user.id).set(user);


  }
}
