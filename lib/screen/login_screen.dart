import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_mmf/model/login_model.dart';
import 'package:test_mmf/screen/api_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon =TextEditingController();
  TextEditingController passCon =TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  //LoginModel data = LoginModel();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.sp).copyWith(top: 100.sp),
          child: Form(
        key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  children: [
                    Text('Sign in',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.sp,color: Color(0xff212226),fontFamily: 'Euclid'),textAlign: TextAlign.right,),
                  SizedBox(width: 15.sp,),
                    Text('Sign up',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.sp,color: Colors.grey.shade300,fontFamily: 'Euclid'),textAlign: TextAlign.right,),
                  ],
                ),
                SizedBox(height: 2.sp,),
                Row(
          children: [
            Container(width: 65.sp,height: 2,color: Color(0xff007AFF),),
            Expanded(child: Container(height: 2,color: Colors.grey.shade300, margin: EdgeInsets.only(right: 10.sp),)),

          ],
        ),
        SizedBox(height: 30.sp,),
                TextFormField(
                  controller: emailCon,
                  validator: (value) {
                    const email =  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    final regExp = RegExp(email);
                    if(value!.isEmpty || value == null){
                      return 'Please enter email';
                    }else if(!regExp.hasMatch(value)){
                      return 'please enter valid mail';
                    }
                    return null;
                  },
        
                  decoration: InputDecoration(
        
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp)),borderSide: BorderSide(width: 1,color: Colors.grey.shade300)),
               hintText: 'enter your email',hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xff949BA5),fontFamily: 'Euclid')
                ),
                ),
                SizedBox(height: 20.sp,),
                TextFormField(
                  controller: passCon,
                  validator: (value) {
                    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if(value!.isEmpty || value == null){
                      return 'Please enter password';
                    } else if (value.length < 8) {
                      return "Password must be atleast 8 characters long";
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'please enter valid password';
                    // }
                    return null;
                  },
                  decoration: InputDecoration(
        
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp)),borderSide: BorderSide(width: 1,color: Colors.grey.shade300)),
               hintText: 'enter your password',hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xff949BA5),fontFamily: 'Euclid')
                ),
                ),
                SizedBox(height: 35.sp,),
                ElevatedButton(
                  style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp))),backgroundColor: MaterialStatePropertyAll(Color(0xff007AFF),),padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15.sp))),
                    onPressed:  isLoading
                        ? null
                        : () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          LoginModel? data = await ApiService().sendData(
                            emailCon.text,
                            passCon.text,
                          );
                          if (data != null && data.status == true) {
                            // Navigate to HomeScreen with data
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(data: data,),
                              ),
                            );
                          } else {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login failed'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('An error occurred'),
                            ),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    }, child: isLoading
                    ? CircularProgressIndicator(
                  color: Colors.white,
                ) : Text('Login',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.sp,color: Colors.white,fontFamily: 'Euclid'),)),
                SizedBox(height: 20.sp,),
                Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xff212226),fontFamily: 'Euclid'),textAlign: TextAlign.right,),
                SizedBox(height: 50.sp,),
        
                Row(
                  children: [
                  Expanded(child: Divider(height: 1,color: Color(0xff212226),thickness: 1.5,endIndent: 10.sp,)),
                    Text('Or signin with',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xff212226),fontFamily: 'Euclid'),),
                    Expanded(child: Divider(height: 1,color: Color(0xff212226),thickness: 1.5,indent: 10.sp,)),
        
                  ],
                ),
                SizedBox(height: 30.sp,),
                Row(
        mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    height: 50.sp,
                    width: 50.sp,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color:Colors.grey.shade200,width: 1.sp,),
        
                    ),
                  child: Image(image: AssetImage('assets/image/google.png')),),
                    SizedBox(width: 20.sp,),
                  Container(
                    height: 50.sp,
                    width: 50.sp,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color:Colors.grey.shade100,width: 1.sp,),
        
                    ),
                    child: Image(image: AssetImage('assets/image/facebook.png')),),
                    SizedBox(width: 20.sp,),
                    Container(
                    height: 50.sp,
                    width: 50.sp,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color:Colors.grey.shade100,width: 1.sp,),
        
                    ),
                    child: Image(image: AssetImage('assets/image/apple.png')),)
                ],),
                SizedBox(height: 50.sp,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have a Account?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Colors.grey,fontFamily: 'Euclid'),),
                    Text(' Sign up',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Color(0xff5096F1),fontFamily: 'Euclid'),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
