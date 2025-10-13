import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/back_groung.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/text_from_filde_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/auth/components/description_text_field.dart';
import 'package:manzal_office/features/auth/components/footer.dart';
import 'package:manzal_office/features/auth/components/header.dart';
import 'package:manzal_office/features/auth/components/title.dart';
import 'package:manzal_office/features/auth/controller/auth_cubit.dart';

class Register extends StatelessWidget {
  Register({super.key});
  TextEditingController officeName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController profitPercentage = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
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
                Header(
                  iconOnTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.05),

                TitleComponent(
                  title1: "Create Your  ",
                  title2: 'Account',
                  disc: 'discover the best and cheapest properties with us',
                ),
                SizedBox(height: screenHeight(context) * 0.05),
                Expanded(
                  child: Form(
                    key: formkey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFromFildeComponent(
                              hintText: 'Office Name',
                              controller: officeName,
                              prefixIcon: Icons.home_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),

                            TextFromFildeComponent(
                              hintText: 'Email',
                              controller: email,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            TextFromFildeComponent(
                              hintText: 'Phone',
                              controller: phone,
                              prefixIcon: Icons.phone_android_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            TextFromFildeComponent(
                              hintText: 'Profit Percentage',
                              controller: profitPercentage,
                              prefixIcon: Icons.percent,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              }, // لقبول أرقام عشرية
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            DescriptionResizableField(
                              controller: description,
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            TextFromFildeComponent(
                              hintText: 'passWord',
                              controller: password,
                              prefixIcon: Icons.lock_outline,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            TextFromFildeComponent(
                              hintText: 'rePassWord',
                              controller:passwordConfirm,
                              prefixIcon: Icons.lock_outline,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.015),
                            Footer(
                              text: "Have Account?",
                              textButton: 'Login',
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: screenHeight(context) * 0.05),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                var cubit = AuthCubit();
                                if(state is RegisterLoadState){
                                  return Center( child: CircularProgressIndicator(color: mainColor1,),);
                                }else{
                                return Center(
                                  child: SizedBox(
                                    width: screenWidth(context) * 0.8,
                                    child: ButtomComponent(
                                      text: 'Register',
                                      onPressed: () {
                                        cubit.register(
                                          officeName.text,
                                          email.text,
                                          phone.text,
                                          profitPercentage.text,
                                          description.text,
                                          password.text,
                                          passwordConfirm.text,
                                          context,
                                        );
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
