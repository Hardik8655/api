import 'package:flutter/material.dart';
import 'package:http/http.dart';

//  code for post Api
// SingUp and Login

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                SignUp(emailController.text.toString(),
                    passController.text.toString());
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.deepPurple,
                ),
                child: const Center(
                  child:
                      Text("Sign Up...", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//  API COLLING CODE

  void SignUp(String email, String password) async {
    try {
      Response response = await post(Uri.parse("https://reqres.in/api/login"),
          body: {"email": email, "password": password});
      if (response.statusCode == 400) {
        print("Account Created Successfully");
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

// API CALLING FOR LOGIN

// void login(String email, String password) async {
//   try {
//     Response response = await post(Uri.parse("https://reqres.in/api/login"),
//         body: {"email": email, "password": password});
//     if (response.statusCode == 200) {
//       print("Login Successfully");
//     } else {
//       print("Login failed");
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

}
