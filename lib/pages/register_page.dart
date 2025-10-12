import 'package:chatterbro/components/background_color.dart';
import 'package:chatterbro/components/button.dart';
import 'package:chatterbro/components/text_field.dart';
import 'package:chatterbro/home_page.dart';
import 'package:chatterbro/pages/login_page.dart';
import 'package:chatterbro/services/auth_services.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController password2 =TextEditingController();
  void registerlogic(BuildContext context) async {
    final authService=AuthServices();
    if(password.text==password2.text){ 
      try{
        await authService.signUpWithEmailPassword(email.text.trim(), password.text.trim());
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
      }
      catch(e){
        showDialog(context: context,builder:(context)=>AlertDialog(
          title: Text(e.toString()),
        ));
        }
      }
      else{
        showDialog(context: context, builder:(context)=>const AlertDialog(title: Text("Passwords dont match"),));
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundColor(
        color1: Color(0xFF4ADEDE),
        color2: Color(0xFF1E1E2F),
        mychild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              height:430,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 213, 213),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(color: Colors.black12)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text("Hello there please register",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                    SizedBox(height: 35),
                    TextFields(
                      textheight: 50,
                      textwidth: 260,
                      visibility: false, 
                      control: email, 
                      myhinttext: "enter your email."
                    ),
                    SizedBox(height: 10),
                    TextFields(
                      textheight: 50,
                      textwidth: 260,
                      visibility: true,
                      control: password, 
                      myhinttext: "Enter your password."
                    ),
                    SizedBox(height: 10),
                    TextFields(
                      textheight: 50,
                      textwidth: 260,
                      visibility: true,
                      control: password2, 
                      myhinttext: "Confirm password."
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      wid: 250, 
                      len: 50,
                      text:"create a account", 
                      buttoncolor: Colors.pinkAccent,
                      ontap:()=>registerlogic(context)
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already have a account "),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context)=>LoginPage()
                            )
                          ),
                          child: Text("go to login.",style:TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}