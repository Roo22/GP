import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/users/users_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';


import '../../main.dart';
import '../trainers/trainers_screen.dart';

class Donate extends StatelessWidget {

  var bloodGroupController = TextEditingController();
  var diseaseController = TextEditingController();
  var lasttimeController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        // if(state is AppSendRequestSuccessState)
        //   if(AppCubit.get(context).userModel.userType!='Trainer')
        //     navigateTo(context,TrainersScreen());
        //   else
        //     navigateTo(context,UsersScreen());
        // else
          if(state is AppSendRequestErrorState)
          {
            showToast(
                message: state.error,
                state:ToastStates.ERROR
            );
          }

      },
      builder: (context, state) {
        var selectedProgram;
        if(AppCubit.get(context).userModel!.userType!='Trainer')
          selectedProgram=AppCubit.get(context).userModel!.bodyType;
        return Scaffold(
          appBar: AppBar(
            notificationPredicate: defaultScrollNotificationPredicate,
            title:const Text("Program Request "),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 32,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children:[
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: ageController,
                    //   type: TextInputType.number,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Age must not be empty';
                    //     }
                    //   },
                    //   label: 'العمر',
                    //   prefix: Icon(Icons.opacity),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                  SizedBox(
                  height: 40,
                ),

                    DropdownButtonFormField<String>(
                      hint: Text('Choose your Program'),
                      value: selectedProgram,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'This field must not be empty';
                        }
                      },
                      items: ['Lose Weight', 'Gain Weight', 'Maintain Weight', 'Gain Muscle', 'Modify my diet', 'Increase Step Count', 'Get Shredded', 'Increase Strength']
                          .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value){
                        print(value);
                        selectedProgram =value!;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)) ,
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: diseaseController,
                    //   type: TextInputType.text,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Disease must not be empty';
                    //     }
                    //   },
                    //   label: 'الامراض ',
                    //   prefix: Icon(Icons.health_and_safety),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: lasttimeController,
                    //   type: TextInputType.datetime,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Last Time must not be empty';
                    //     }
                    //   },
                    //   label: 'اخر مرة اتبرعت ',
                    //   prefix: Icon(Icons.hourglass_top),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // Container(
                    //   color: defaultColor,
                    //   margin: EdgeInsets.symmetric(
                    //     horizontal: 10,
                    //     vertical: 5,
                    //   ),
                    //   height: 60,
                    //   width: double.infinity,
                    //
                    //   child: TextButton(onPressed: (){
                    //
                    //   }, child: Text(
                    //     'Request',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 19,
                    //       color: Colors.white,
                    //     ),
                    //   )),
                    // ),
                    SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: state is AppSendRequestLoadingState ,
                        builder: (context) => Center(child: CircularProgressIndicator()),
                        fallback: (context) =>  defaultButton(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              if(AppCubit.get(context).userModel!.userType=='Trainer')
                              {
                                if(selectedProgram=='Lose Weight')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Lose Weight' || element.bodyType=='Gain Weight'|| element.bodyType=='Get Shredded' || element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Gain Weight')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Gain Weight' || element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Maintain Weight')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Maintain Weight' || element.bodyType=='Gain Muscle'|| element.bodyType=='Get Shredded' || element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Gain Muscle')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Gain Muscle'|| element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Get Shredded')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Get Shredded'|| element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Increase Strength')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Modify my Diet')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    AppCubit.get(context).sendRequest(
                                      bodyType:selectedProgram!,
                                      dateTime: DateTime.now().toString(),
                                      receiverId: element.uId!,
                                    );
                                  });
                                }
                                else if(selectedProgram=='Increase Step Count')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bodyType=='Increase Step Count' || element.bodyType=='Gain Weight' || element.bodyType=='B-' || element.bodyType=='Increase Strength')
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType:selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                              }
                              else if (AppCubit.get(context).userModel!.userType!='Trainer')
                              {
                                if(selectedProgram=='Lose Weight')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.FirstProgram!>0 || element.SecondProgram!>0 || element.SeventhProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                if(selectedProgram=='Gain Weight')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.SecondProgram!>0 ||element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Maintain Weight')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.ThirdProgram!>0 || element.SixthProgram!>0 || element.SeventhProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Gain Muscle')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.SixthProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Get Shredded')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.SeventhProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Increase Strength')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Modify my Diet')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.FifthProgram!>0 || element.SixthProgram!>0 || element.FirstProgram!>0 || element.SecondProgram!>0 || element.ThirdProgram!>0 || element.SixthProgram!>0 || element.SeventhProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedProgram=='Increase Step Count')
                                {
                                  AppCubit.get(context).trainers.forEach((element) {
                                    if(element.SixthProgram!>0 || element.SecondProgram!>0 || element.SixthProgram!>0 || element.EighthProgram!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bodyType: selectedProgram!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                              }
                            }
                            var username= AppCubit.get(context).userModel?.name;
                            //  AppCubit.get(context).sendPushNotification(deviceToken!);
                            AppCubit.get(context).showNotification(
                                username,
                                " Your Request has been sent successfully ");
                          },
                          text: 'Request',
                          isUppercase: false,
                        ),
                    ),

                  ]
        )
        )
            )
          )
        );
      },
    );
  }
}
