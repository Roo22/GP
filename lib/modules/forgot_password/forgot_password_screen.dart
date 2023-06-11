import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  var linkController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultFormField(
                    controller: linkController,
                    type: TextInputType.text,
                    validate: (value){
                      if(value.isEmpty)
                      {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'link'
                ),
                SizedBox(height: 20),
                defaultButton(
                  function:(){
                    if(formKey.currentState!.validate())
                    {
                      AppCubit.get(context).link=linkController.text;
                      print('succees');
                    }
                  } ,
                  text: 'send',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

