import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/back_groung.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/component/text_from_filde_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/auth/components/footer.dart';
import 'package:manzal_office/features/auth/components/title.dart';
import 'package:manzal_office/features/auth/controller/auth_cubit.dart';
import 'package:manzal_office/features/auth/register.dart';
import 'package:manzal_office/features/home_page/home_page.dart';

import 'components/header.dart';

class Login extends StatelessWidget {
  Login({super.key});
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  var formkey = GlobalKey<FormState>();
  void getToken() async {
    print("cooom");
    String? token = await messaging.getToken();
    print("FCM Token: $token");
    // أرسل التوكن إلى الباك إند (Laravel) وخزنه في قاعدة البيانات
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BackGround(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight(context) * 0.04),
                //  Header(textOnTap:(){} ,headerText: "skip",iconOnTap: (){Navigator.pop(context);},),
                SizedBox(height: screenHeight(context) * 0.05),

                TitleComponent(
                  title1: "Let's ",
                  title2: 'Sign In',
                  disc: 'discover the best and cheapest properties with us',
                ),
                SizedBox(height: screenHeight(context) * 0.05),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFromFildeComponent(
                              hintText: 'Email',
                              controller: email,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email';
                                }

                                // Regex بسيط ومرن لقبول أغلب أشكال الإيميلات
                                String pattern = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
                                RegExp regex = RegExp(pattern);

                                if (!regex.hasMatch(value.trim())) {
                                  return 'Please enter a valid Email (e.g., example@gmail.com)';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            TextFromFildeComponent(
                              hintText: 'passWord',
                              controller: passWord,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            Footer(
                              text: "Don't Have Account?",
                              textButton: 'Register',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: screenHeight(context) * 0.05),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                var cubit = AuthCubit.get(context);
                                if(state is LoginLoadState){
                                  return Center(child: CircularProgressIndicator(color: mainColor1,),);
                                }else{
                                return Center(
                                  child: Container(
                                    width: screenWidth(context) * 0.8,
                                    child: ButtomComponent(
                                      text: 'Login',
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          cubit.login(
                                            email.text,
                                            passWord.text,
                                            context,
                                          );
                                        }
                                      /*  await FirebaseMessaging.instance.deleteToken();
                                        getToken();*/
                                      },
                                    ),
                                  ),
                                );}
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
