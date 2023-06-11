import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../blood/Donate.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 140,
                            width:double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)
                              ),
                              image:DecorationImage(image: NetworkImage(
                                userModel!.cover??'',
                              ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userModel.image??''),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    userModel.name??'',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  if(AppCubit.get(context).userModel!.userType!='Trainer')
                    Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  ' Enrolled Porgram:  ${AppCubit.get(context).userModel!.bodyType}',
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:OutlinedButton(
                          onPressed: (){
                            navigateTo(context, Donate(),);
                          },
                          child: Text(
                            'Request',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        onPressed: (){
                          navigateTo(context, EditProfileScreen(),);
                        },
                        child: Icon(
                          Icons.edit,
                          size: 16,
                        ),

                      ),
                    ],
                  ),
                  if(AppCubit.get(context).userModel.userType=='Trainer')
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (4).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.FirstProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (8).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.SecondProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (5).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.ThirdProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (7).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.FourthProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (3).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.FifthProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (10).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.SixthProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (6).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.SeventhProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(image:AssetImage('assets/images/blood-type (9).png')),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppCubit.get(context).userModel.EighthProgram??'Not uploaded yet'}',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],),
            ),
          ),
        );
      },
    );
  }
}


