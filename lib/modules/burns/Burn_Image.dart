import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';

class BurnImage extends StatelessWidget {
  File? image;
  BurnImage(image)
  {
    this.image=image;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.file(image!,),
                //Image(image:AssetImage('assets/images/first-aid-kit.gif')),
                Text(AppCubit.get(context).mlResult),
              ],
            ),
          )
          ,);
      },
    );
  }
}
