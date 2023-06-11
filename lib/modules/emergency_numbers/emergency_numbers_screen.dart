
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 35,
            end: 3,
            start: 3,
          ),
          child: Container(
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
                    Text(
                      'Emergency numbers',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/ambulance.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/2955/2955666.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Ambulance',
                                        style: TextStyle(
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                          '123',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: (){
                                launch('tel:123');
                              },
                            ),
                          ),
                          SizedBox(width:10,),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/firetruck.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/4325/4325959.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Fire truck',
                                        style: TextStyle(
                                            color: defaultColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '180',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              onTap: (){
                                launch('tel:180');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/police.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/1048/1048342.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Police',
                                        style: TextStyle(
                                            color: defaultColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '122',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              onTap: (){
                                launch('tel:122');
                              },
                            ),
                          ),
                          SizedBox(width:10,),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/electricity.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/3097/3097969.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Electricity',
                                        style: TextStyle(
                                            color: defaultColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '121',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              onTap: (){
                                launch('tel:121');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/gas.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/3144/3144737.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Gas',
                                        style: TextStyle(
                                            color: defaultColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '129',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: (){
                                launch('tel:129');
                              },
                            ),
                          ),
                          SizedBox(width:10,),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image(image:AssetImage('assets/images/traffic.png')),//Image(image:NetworkImage('https://cdn-icons-png.flaticon.com/512/2043/2043115.png')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Traffic police',
                                        style: TextStyle(
                                            color: defaultColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '128',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                              onTap: (){
                                launch('tel:128');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius:BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
