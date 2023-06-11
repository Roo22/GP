import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class Plan extends StatelessWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('Recipes'),
          ),
          body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:Padding(
              padding: const EdgeInsets.all(20),
              child:Column(
                children: [
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/burn (2).png')),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                '[Food]',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have any skin burns, please follow these guide.',

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(burn: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).isBurnAidVisible)
                    Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Cool the burn with cool or lukewarm running water for 20 minutes.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    " Don't use ice, iced water, or any creams or greasy substances such as butter.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:defaultColor,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Remove any clothing or jewellery that's near the burnt area of skin, including babies' nappies.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    " Don't move anything that's stuck to the skin.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:defaultColor,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Make sure the person keeps warm – by using a blanket, for example.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Take care not to rub it against the burnt area.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:defaultColor,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Cover the burn by placing a layer of cling film over it – a clean plastic bag could also be used for burns on your hand.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Use painkillers to treat any pain.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "If the face or eyes are burnt, sit up as much as possible, rather than lying down - this helps to reduce swelling.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[800],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/blood.png')),//wound
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Bleeding',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have bleeding, please follow these guide.',

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(bleeding: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).isBleedingAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Apply direct pressure to the bleeding wound.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800],
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      " Raise the injured area.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800],
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Column(
                                      children: [
                                        Text(
                                          "If a foreign body is embedded in the wound.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:Colors.green[800],
                                          ),
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                              size: 10,

                                            ),
                                            SizedBox(width:10,),
                                            Expanded(
                                                child:Text(
                                                  "DO NOT remove it but apply padding on either side of the object and build it up to avoid pressure on the foreign body.",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: defaultColor,
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.blueAccent,
                                              size: 10,

                                            ),
                                            SizedBox(width:10,),
                                            Expanded(
                                                child:Text(
                                                  "Hold the padding firmly in place with a roller bandage or folded triangular bandage applied in a criss-cross method to avoid pressure on the object.",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue[800],
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Keep the patient at total rest.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800],
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Seek medical assistance.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/poison.png')),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Poisoning',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have toxicosis, please follow these guide.',

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(poisoning: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).isPoisoningAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Call 123 or your local emergency number immediately if the person is:",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Drowsy or unconscious.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Having difficulty breathing or has stopped breathing.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Uncontrollably restless or agitated.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Having seizures.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Known to have taken medications, or any other substance, intentionally or accidentally overdosed.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/heart-beats.png')),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Resuscitation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'if you need to resuscitate someone, please follow these guide.',

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(Resuscitation: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).isResuscitationAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Call 123 or ask someone else to",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Lay the person on their back and open their airway.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Check for breathing. If they are not breathing, start CPR.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Perform 30 chest compressions.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Perform two rescue breaths.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Repeat until an ambulance or automated external defibrillator (AED) arrives",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/asthma.png')),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Asthma',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have Asthma attack, please follow these guide.',

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(Asthma: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).isAsthmaAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Lay the person on their back and open their airway.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Sit the person upright.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Give 4 separate puffs of blue/grey reliever puffer.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Wait 4 minutes.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "If breathing does not return to normal, call 123 for an ambulance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),


          ),

        );
      },
    );
  }
}
