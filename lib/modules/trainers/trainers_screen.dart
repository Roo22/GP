import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/trainer_model.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../blood/requests_screen.dart';

class TrainersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  ConditionalBuilder(
          condition: AppCubit.get(context).trainers.length >0,
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                  )),
              title:Text('Trainers') ,
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildTrainerItem(AppCubit.get(context).trainers[index],context),
              separatorBuilder: (context, index) => myDevider(),
              itemCount: AppCubit.get(context).trainers.length,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildTrainerItem(TrainerModel model,context)=> InkWell(
    onTap: (){
      navigateTo(context,Requests(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(model.image!),
            radius: 25,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            model.name!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.4,),
          ),
        ],),
    ),
  );
}
