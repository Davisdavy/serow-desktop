import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/layout.dart';
import 'package:serow/widgets/custom_text.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left:58.0, top: 50),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/logo-main.png", height: 70,),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Login", style: TextStyle(color: bgColor, fontSize: 28, fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Welcome back! Enter your credentials to login.", style: TextStyle(color: bgColor, fontSize: 12),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email Address", style: TextStyle(color: bgColor, fontSize: 16, fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 400,

                                child: TextField(
                                  decoration: InputDecoration(
                                    //  labelText: "Email Address",
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(fontSize: 14),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: primaryColor, width: 0.4),
                                          borderRadius: BorderRadius.circular(5)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.blueGrey, width: 0.4),
                                          borderRadius: BorderRadius.circular(5))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Password", style: TextStyle(color: bgColor, fontSize: 16, fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 400,
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    //  labelText: "Email Address",
                                      hintText: "Password",
                                      hintStyle: TextStyle(fontSize: 14),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: primaryColor, width: 0.4),
                                          borderRadius: BorderRadius.circular(5)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.blueGrey, width: 0.4),
                                          borderRadius: BorderRadius.circular(5))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(value: true, onChanged: (value) {}),
                                ),

                                CustomText(text: "Remember Me",
                                size: 14,
                                  color: Colors.blueGrey,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(width: 140,),
                            CustomText(
                                size: 14,
                                weight: FontWeight.w500,
                                text: "Forgot password?",
                                color: primaryColor,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: InkWell(
                          onTap: (){
                            //Get.offAllNamed(rootRoute);
                            Get.offAll(() => Layout());
                          },
                          child: Container(
                            decoration: BoxDecoration(color: primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            width: 400,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CustomText(
                              text: "Login",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 18,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Not registered yet? ", style: TextStyle(
                               fontWeight: FontWeight.w500,
                                color: Colors.blueGrey
                              )),
                              TextSpan(text: "Contact Sales ", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500,))
                            ]
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF5d5b8c),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:60.0, bottom: 80),
                      child: Image.asset("assets/images/login_illustration.png", ),
                    ),
                    Text("Get the most out of", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),),
                    Text("your business.", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20.0,),
                    Text("Consistent quality and experience across", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w200),),
                    Text("all platforms and devices.", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w200),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
