import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is RegisterErrorState)
          {
            showToast(
                message: state.error,
                state:ToastStates.ERROR
            );
          }
          if(state is RegisterSuccessState)
          {
            navigatAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   iconTheme: IconThemeData(color: Colors.red[800]),
            // ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:[
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color:defaultColor,
                                )),
                          ],
                        ),
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage('https://www.upload.ee/image/15319380/emergency.png'),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Register",
                          style:TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value.isEmpty)
                            {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icon(Icons.person),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password must not be empty';
                            }
                          },
                          label: 'Password',
                          prefix: Icon(Icons.lock),
                          suffix: IconButton(
                            onPressed: (){},
                            icon: IconButton(
                                onPressed: (){
                                  RegisterCubit.get(context).changePasswordVisibility();
                                },
                                icon: Icon(RegisterCubit.get(context).suffix),
                            ),
                          ),
                          obsecure: RegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'phone',
                          prefix: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email adress must not be empty';
                            }
                          },
                          label: 'Email',
                          prefix: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        DropdownButtonFormField<String>(
                          hint: Text('Who are you ?'),
                          value: RegisterCubit.get(context).selectedUserType,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'This field must not be empty';
                            }
                          },
                          items: ['User', 'Trainer']
                              .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          onChanged: (value){
                            print(value);
                            RegisterCubit.get(context).changeUserType(value);
                          },
                          decoration: InputDecoration(
                            border: RegisterCubit.get(context).outLineBorder ? OutlineInputBorder() : null,
                            enabledBorder: RegisterCubit.get(context).outLineBorder  ? OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0)) : null,
                            disabledBorder: RegisterCubit.get(context).outLineBorder
                                ? OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0))
                                : null,
                            focusedBorder: RegisterCubit.get(context).outLineBorder
                                ? OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0))
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        if(RegisterCubit.get(context).selectedUserType!='Trainer')
                          DropdownButtonFormField<String>(
                            hint: Text('Select your Plan type'),
                            value: RegisterCubit.get(context).selectedProgram,
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
                              RegisterCubit.get(context).selectedProgram =value!;
                            },
                            decoration: InputDecoration(
                              border: RegisterCubit.get(context).outLineBorder ? OutlineInputBorder() : null,
                              enabledBorder: RegisterCubit.get(context).outLineBorder  ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:  Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0)) : null,
                              disabledBorder: RegisterCubit.get(context).outLineBorder
                                  ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:  Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0))
                                  : null,
                              focusedBorder: RegisterCubit.get(context).outLineBorder
                                  ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:  Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0))
                                  : null,
                            ),
                          ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    bodyType:RegisterCubit.get(context).selectedProgram,
                                    userType:RegisterCubit.get(context).selectedUserType,
                                  );
                                }
                              },
                              text: 'Register',
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
