import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          body: Stack(
            children: [
              Container(
                height: 250,
                color: defaultColor,

              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 20,
                  left: 20,
                  bottom:20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color:Colors.white,
                        ),
                      alignment: AlignmentDirectional.topStart,
                    ),
                    Text(
                        'Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                        '${AppCubit.get(context).userModel!.name}',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 175,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.dark_mode_outlined,
                                color: defaultColor,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.w500
                              ),
                            ),
                            Spacer(),
                            Switch(
                              //activeTrackColor: defaultColor!.withOpacity(0.7),
                              activeColor: defaultColor,
                              //thumbColor: MaterialStatePropertyAll(defaultColor),
                              value: AppCubit.get(context).isDark,
                              onChanged: (value){
                                print(value.toString());
                                AppCubit.get(context).changeAppMode(swatchValue: value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        );
      },
    );
  }
}
