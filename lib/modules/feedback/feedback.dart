import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/shared/styles/colors.dart';

import '../../shared/cubit/cubit.dart';


class FeedBack extends StatelessWidget {
  FeedBack({Key? key}) : super(key: key);
  final Color firstColor = const Color.fromRGBO(160, 0, 0, 1);
  final Color secondColor = const Color.fromRGBO(0, 0, 0, 1);
  final msgController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  TextEditingController feedBack = TextEditingController();


  sendEmail(String feedBack ,String sub, String _email) async{
    final Email email = Email(
      body: feedBack,
      subject: sub,
      recipients: [_email],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:Padding(
          padding: const EdgeInsets.only(top:30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper() ,
                    child: Container(
                      width:double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:[
                            firstColor,secondColor
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color:Colors.white,
                                )),
                            Text('FeedBack',style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(
                         height: 20,
                        ),
                        Text('Welcome To Our FeedBack Form',style: TextStyle(color: Colors.white, fontSize: 18),),
                        Text('To Hear Your Opinion In Our App',style: TextStyle(color: Colors.white, fontSize: 18),),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 45,
                          foregroundImage:
                          NetworkImage('${AppCubit.get(context).userModel?.image}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Tell Us How We Can Improve',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Row(
                      children: [
                        Expanded(child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: TextFormField(
                            controller: feedBack,
                            style: const TextStyle(color: Colors.black,
                              fontSize: 15,
                            ),
                            validator: (value){
                                if(value!.isEmpty)
                                {
                                  return 'This field must not be empty';
                                }
                              },
                            maxLines: 10,
                            decoration: const InputDecoration(
                              //errorText: 'MustNot Be Null',
                              hintText: ' Write Here.. ',
                              contentPadding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Center(
                      child: Text('How Would You Rate Our App',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Center(
                      child: Column(
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color:Colors.green,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Center(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red[900],
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()) {
                              sendEmail(feedBack.text, 'Feedback message ', 'ma422008@gmail.com,alyehab2011@gmail.com,adamdontcarewest@gmail.com,nehadahmed115@gmail.com,Nehalashraf104@gmail.com,Mohamedhendy146@gmail.com');
                            }
                          },
                          child: Text('Send Now',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ),
                    ),
                    // Stack(
                    //   children: [
                    //     RotatedBox(
                    //       quarterTurns: 6,
                    //       child:  ClipPath(
                    //         clipper: MyClipper() ,
                    //         child: Container(
                    //           width:double.infinity,
                    //           height: 320,
                    //           decoration: BoxDecoration(
                    //             gradient: LinearGradient(
                    //               colors:[
                    //                 firstColor,secondColor
                    //               ],
                    //             ),
                    //             boxShadow: const [
                    //               BoxShadow(
                    //                 color: Colors.red,
                    //                 blurRadius: 12,
                    //                 offset: Offset(0, 6),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     Positioned(
                    //       top: 100,
                    //      // left: 260,
                    //       right: 25,
                    //       child: CircleAvatar(
                    //         radius: 100,
                    //         backgroundImage:
                    //         AssetImage('assets/images/download.jpg'),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-300);
    path.lineTo(size.width, 0);
    path.close();
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}