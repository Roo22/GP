import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/users/edit_user_screen.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../blood/requests_screen.dart';
import '../profile/edit_profile_screen.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.length > 0,
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text('Users'),
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildUserItem(AppCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => myDevider(),
              itemCount: AppCubit.get(context).users.length,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildUserItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, Requests(userModel: model));
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      model.userType!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateToEditUserScreen(context, model);
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      );

  void navigateToEditUserScreen(BuildContext context, UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(user: user),
      ),
    );
  }
}
