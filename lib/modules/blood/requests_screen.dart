import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import '../../models/request_model.dart';
import '../../models/user_model.dart';
import '../../shared/styles/colors.dart';

class Requests extends StatelessWidget {
  var userModel;
  Requests({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getRequests(userModel.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var request = AppCubit.get(context).requests[index];
                          if (AppCubit.get(context).userModel!.uId ==
                              request.senderId) {
                            if (request.text == null)
                              return buildMyRequest(
                                  request, AppCubit.get(context));
                            else
                              return buildMyMessage(request);
                          } else {
                            if (request.text == null)
                              return buildRequest(
                                  request,
                                  AppCubit.get(context).requestsIds[index],
                                  AppCubit.get(context),
                                  context);
                            else
                              return buildMessage(request);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: AppCubit.get(context).requests.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildRequest(RequestModel model, requestId, AppCubit cubit, context) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(30),
                  topEnd: Radius.circular(30),
                  topStart: Radius.circular(30),
                ),
                color: Colors.white, //grey[300],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, //New
                      blurRadius: 1.0,
                      offset: Offset(0, -0.1))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/blood2.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avaliable Program \nOffered by one of our coaches',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                //overflow:TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${model.dateTime!} ',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                //overflow:TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your body-shape matched one of our avaliable programs. Would you like to enroll?',
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '${model.bodyType!} ',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myDevider(),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${userModel.location ?? ''}',
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if (model.isAccepted == null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Decline',
                              ),
                            ),
                          ),
                        if (model.isAccepted == null)
                          SizedBox(
                            width: 10,
                          ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.updateRequestStatus(
                                receiverId: model.receiverId!,
                                dateTime: model.dateTime!,
                                bodyType: model.bodyType!,
                                isAccepted: true,
                                senderId: model.senderId!,
                                requestId: requestId!,
                              );
                              cubit.sendRequest(
                                  bodyType: model.bodyType!,
                                  receiverId: model.senderId!,
                                  dateTime: DateTime.now().toString(),
                                  text: AppCubit.get(context)
                                              .userModel
                                              .userType ==
                                          'Hospital'
                                      ? 'Your request has been accepted you can come to this location : ${AppCubit.get(context).userModel.location}'
                                      : 'Your request has been accepted');
                            },
                            child: Text(
                              model.isAccepted == null
                                  ? 'Accept'
                                  : model.isAccepted == true
                                      ? 'Accepted'
                                      : 'Declined',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    model.isAccepted == null
                                        ? defaultColor
                                        : model.isAccepted == true
                                            ? Colors.green
                                            : Colors.grey[500])),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
  Widget buildMyRequest(RequestModel model, AppCubit cubit) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(30),
                  topEnd: Radius.circular(30),
                  topStart: Radius.circular(30),
                ),
                color: defaultColor?.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/blood2.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avaliable Program \nOffered by one of our coaches',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${model.dateTime!} ',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                //overflow:TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your body-shape matched one of our avaliable programs. Would you like to enroll?',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          //fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '${model.bodyType!} ',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myDevider(),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${cubit.userModel.location}',
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Requested',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey[500])),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
  Widget buildMessage(RequestModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.text!,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: Text(
                        '${model.dateTime!} ',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        //overflow:TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
  Widget buildMyMessage(RequestModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
              color: defaultColor!.withOpacity(0.2),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              children: [
                Text(
                  model.text!,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: Text(
                        '${model.dateTime!} ',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        //overflow:TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}
