import 'dart:collection';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/Plan/Plan.dart';
import 'package:graduation_project/modules/about/about_screen.dart';

import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../modules/Recipes/Recipe.dart';
import '../modules/emergency_numbers/emergency_numbers_screen.dart';
import '../modules/feedback/feedback.dart';
import '../modules/forgot_password/forgot_password_screen.dart';
import '../modules/trainers/trainers_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/users/users_screen.dart';
import '../shared/styles/themes.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController =TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).getCustomMarker();
        return ConditionalBuilder(
            condition: state is AppGetUserLoadingState|| state is AppGetTrainerLoadingState,
            builder: (context) => Center(child: CircularProgressIndicator()),
            fallback: (context) => Scaffold(
              key: scaffoldKey,
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(30.033333, 31.233334),
                        zoom: 10
                    ),
                    mapType:AppCubit.get(context).mapTypeUser==popupMenuValues.normalView? MapType.normal : AppCubit.get(context).mapTypeUser== popupMenuValues.satelliteView? MapType.hybrid:MapType.terrain,

                    onMapCreated: (GoogleMapController googleMapController) {

                      // for search function
                      AppCubit.get(context).onMapCreated(googleMapController);
                      AppCubit.get(context).getCurrentLocation();
                      AppCubit.get(context).saveMyLocation();

                      // darkMapTheme
                      if(state is AppChangeModeState && AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      else if(AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      //markers
                      addHomeMarkers(context);
                      addProgramMarkers(context);
                      addBurnsMarker(context);

                    },

                    buildingsEnabled: true,
                    trafficEnabled: true,
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: state is AppSearchSuccessState?AppCubit.get(context).mySearchMarkers: AppCubit.get(context).currentIndex==0 && state is !AppSearchSuccessState? AppCubit.get(context).myHomeMarkers :AppCubit.get(context).currentIndex==1 && state is !AppSearchSuccessState?AppCubit.get(context).myProgramMarkers:AppCubit.get(context).myBurnsMarkers,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppCubit.get(context).isDark? HexColor('282828'):Colors.white,
                          child: IconButton(
                              onPressed: (){
                                scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu_rounded,
                                size: 25,
                                color:AppCubit.get(context).isDark?Colors.grey:defaultColor,
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: CupertinoSearchTextField(
                          controller: searchController,
                          backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                          itemColor: Colors.grey,
                          style: TextStyle(color: Colors.grey),
                          autocorrect: true,
                          onSubmitted: (value){
                            AppCubit.get(context).searchAndNavigate();
                          },
                          onChanged: (value){
                            AppCubit.get(context).changeSearchAddress(value);
                          },

                        )),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                          child: PopupMenuButton<popupMenuValues>(
                            onSelected:(value){AppCubit.get(context).changeMapView(value);},
                            //color: AppCubit.get(context).isDark? HexColor('282828'):null,
                            itemBuilder: (context)=> [
                              PopupMenuItem(
                                child:Text('Satellite view'),
                                value:popupMenuValues.satelliteView,
                              ),
                              PopupMenuItem(
                                child:Text('Normal view'),
                                value:popupMenuValues.normalView,
                              ),
                              PopupMenuItem(
                                child:Text('Terrain view'),
                                value:popupMenuValues.terrainnView,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  if(AppCubit.get(context).currentIndex==1)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedFloatingActionButton(
                          //Fab list
                            curve: Curves.bounceInOut,
                            durationAnimation: 300,
                            spaceBetween: -10.0,
                            fabButtons: <Widget>[
                              AppCubit.get(context).float1(context),AppCubit.get(context).float2(context)
                            ],
                            key : key,
                            colorStartAnimation: defaultColor??Colors.red,
                            colorEndAnimation: defaultColor??Colors.red,
                            animatedIconData: AnimatedIcons.menu_close //To principal button
                        ),
                      ),
                    ),
                  if(AppCubit.get(context).currentIndex==2)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedFloatingActionButton(
                          //Fab list
                            curve: Curves.bounceInOut,
                            durationAnimation: 300,
                            spaceBetween: -10.0,
                            fabButtons: <Widget>[
                              AppCubit.get(context).float3(context),AppCubit.get(context).float4(context)
                            ],
                            key : key,
                            colorStartAnimation: defaultColor??Colors.red,
                            colorEndAnimation: defaultColor??Colors.red,
                            animatedIconData: AnimatedIcons.menu_close //To principal button
                        ),
                      ),
                    ),

                ],
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        myDrawer(context),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (value) {
                  AppCubit.get(context).changeIndex(value);
                },
                items:  AppCubit.get(context).userModel!.userType!='Trainer'?AppCubit.get(context).bottomItemsWithBurnsItem :AppCubit.get(context).bottomItem,
              ),


            ),
        );
      },
    );
  }


  Widget myDrawer(context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(25.0),
              child: Row(
                children: [
                  Text(
                    'FoodieMate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: defaultColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(context,ProfileScreen());
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.image}'),
                      radius: 25,

                    ),
                  ),
                ],
              ),
            ),
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.food_bank,
            itemName: 'Recipes',
            onTap: () {
              navigateTo(context, Recipe());
            },
          ),
          menuItem(
            itemIcon: Icons.sports_gymnastics_sharp,
            itemName: 'Plans',
            onTap: () {
              navigateTo(context, Plan());
            },
          ),
          menuItem(
            itemIcon: Icons.emergency_outlined,
            itemName: 'Emergency numbers',
            onTap: () {
              navigateTo(context, EmergencyNumbersScreen());
            },
          ),
          //if(AppCubit.get(context).userModel?.userType=='Admin')
          menuItem(
            itemIcon: Icons.local_hospital_outlined,
            itemName: 'Trainers',
            onTap: () {
              AppCubit.get(context).getTrainerData();
              navigateTo(context, TrainersScreen());
            },
          ),
          //if(AppCubit.get(context).userModel?.userType=='Admin')
            menuItem(
            itemIcon: CupertinoIcons.person_2,
            itemName: 'Users',
            onTap: () {
              AppCubit.get(context).getUsers();
              navigateTo(context, UsersScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.settings_outlined,
            itemName: 'Settings',
            onTap: () {
              navigateTo(context, SettingsScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.logout,
            itemName: 'Logout',
            onTap: () {
              AppCubit.get(context).signOut(context);
            },
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.info_outline,
            itemName: 'About',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, AboutScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'Feedback',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, FeedBack());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'api link',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, ForgotPasswordScreen());
            },
          ),
        ],
      ),
    ),
  );
  void addBurnsMarker(context) {
    AppCubit.get(context).addBurnsMarker(
      markerId: '1',
      markerPosition: const LatLng(30.209562,31.533938 ),
      infoWindowTitle: 'Trainer legitimacy Assembly for tumors, burns مستشفي الجمعية الشرعية للاورام والحروق ',
    );

    AppCubit.get(context).addBurnsMarker(
      markerId: '2',
      markerPosition: const LatLng(30.0214489, 31.4904086),
      infoWindowTitle: 'El-Demerdash Hospital مستشفى الدمرداش',
    );

  AppCubit.get(context).addBurnsMarker(
    markerId: '3',
    markerPosition: const LatLng(30.047562,31.518687),
    infoWindowTitle: 'New Cairo Ahl Maser مستشفى أهل مصر القاهرة الجديدة ',
  );
  AppCubit.get(context).addBurnsMarker(
    markerId: '4',
    markerPosition: const LatLng(30.045063,31.266188),
    infoWindowTitle: 'Al Hussein University Hospital مستشفى الحسين التخصصي',
  );
  AppCubit.get(context).addBurnsMarker(
    markerId: '5',
    markerPosition: const LatLng(30.096438,31.239688),
    infoWindowTitle: 'مستشفى معهد ناصر للبحوث والعلاج',
  );
  }
  void addProgramMarkers(context){
    AppCubit.get(context).addBloodMarker(
        markerId: '1',
        markerPosition: const LatLng(30.05160665975826, 31.21054654046658),
        infoWindowTitle:'المركز القومى لنقل الدم',
        infoWindowDescription: 'العجوزة، حي العجوزة، الجيزة 3753530'
    );

    AppCubit.get(context).addBloodMarker(
        markerId: '2',
        markerPosition: const LatLng(30.070037976343123, 31.284155908532693),
        infoWindowTitle: 'المركز الإقليمي لنقل الدم بالعباسية',
        infoWindowDescription: ' امام, مدرسة '
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '3',
      markerPosition: const LatLng(30.015734113461725, 31.22772343015096),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
      infoWindowDescription: 'استكشاف المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '4',
      markerPosition: const LatLng(30.043390224368093, 31.217853117984525),
      infoWindowTitle: 'مركز نقل الدم بمستشفى الدكتور مجدى',
      infoWindowDescription: 'شارع بولس حنا، الدقي قسم، قسم الدقي، الجيزة 3753410',
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '5',
      markerPosition: const LatLng(30.065843713162607, 31.244354625377646),
      infoWindowTitle: 'بنك الدم المركزى',
      infoWindowDescription: ' الهلال الأحمر المصري، الجيارة، الأزبكية، محافظة القاهرة 4320151',
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '6',
      markerPosition: const LatLng(30.05192076644373, 31.211052163215275),
      infoWindowTitle: 'المركز القومى لنقل الدم National Blood Transfusion Center, 26X6+MCG',
      infoWindowDescription: 'العجوزة، العمرانية, الجيزة 3753530',
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '7',
      markerPosition: const LatLng(30.04484433519289, 31.210344506356613),

      infoWindowTitle: 'مركز نقل الدم ومشتقاته بمستشفي الزراعيين',
      infoWindowDescription: '26R6+W57، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة 3751254',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '8',
      markerPosition: const LatLng(30.037857242715162, 31.209218132614158),
      infoWindowTitle: 'المركز القومى لنقل الدم',
      infoWindowDescription: ',26M6+P4 قسم الدقي,15 May Bridge، الدكتور السبكي',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '9',
      markerPosition: const LatLng(30.05212242683355, 31.211021180236536),
      infoWindowTitle: 'بنك الدم السويسري، المستشفي السويسري',
      infoWindowDescription: ',0237613117، العجوزة، حي العجوزة، الجيزة 3753530',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '10',
      markerPosition: const LatLng(30.054054012579744, 31.210334534735367),
      infoWindowTitle: 'المركز القومى لنقل الدم',
      infoWindowDescription: 'البطل أحمد عبد العزيز امام بنك hsbc,، العمرانية، الجيزة,0233374317',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '11',
      markerPosition: const LatLng(30.045155859720996, 31.23022679471311),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم',
      infoWindowDescription: '987 كورنيش النيل، باب اللوق، عابدين، محافظة القاهرة 4272040',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '12',
      markerPosition: const LatLng(30.07346400739051, 31.28485888329649),
      infoWindowTitle: 'بنك الدم الاقليمي',
      infoWindowDescription: '378M+9X5، Unnamed Road, السرايات، الوايلى،، الوايلى، محافظة القاهرة',
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '13',
      markerPosition: const LatLng(30.02323041387819, 31.237252230235853),
      infoWindowTitle: 'بنك الدم 57357',
      infoWindowDescription: ',0225351500,Children Canser Hospital, زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '14',
      markerPosition: const LatLng(30.073166901070287, 31.281462942806964),
      infoWindowTitle: 'Greek Hospital Blood Bank :: بنك الدم المستشفى اليوناني',
      infoWindowDescription: '15 شارع السرايات, العباسية,0226836668',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '15',
      markerPosition: const LatLng(30.025424652831912, 31.237583933650427),
      infoWindowTitle: 'مستشفى سرطان الاطفال 57357',
      infoWindowDescription: ',0225351500,سكة حديد المحجر، زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '16',
      markerPosition: const LatLng(30.029817886746002, 31.232273542392065),
      infoWindowTitle: 'جمعية اصدقاء المبادرة القومية ضد السرطان',
      infoWindowDescription: '33 القصر العيني، العيني، قسم السيدة زينب، محافظة القاهرة,4260016,0225353040,',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '17',
      markerPosition: const LatLng(30.044517238506575, 31.210157081923427),
      infoWindowTitle: 'مستشفى الزراعيين',
      infoWindowDescription: '1 ش النهضة بجوار وزارة الزراعة، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة,0233377677',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '18',
      markerPosition: const LatLng(30.605758347137343, 31.006484897177497),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم بشبين الكوم',
      infoWindowDescription: 'H2F6+VR2،,0482331379,قسم شبين الكوم، المنوفية 6132703',
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '19',
      markerPosition: const LatLng(30.025721902404115, 31.237927256401008),
      infoWindowTitle: 'مستشفى د. محمد الشبراويشى',
      infoWindowDescription: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444',
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '20',
      markerPosition: const LatLng(
          30.06389801557521, 31.259661948463698 ),
      infoWindowTitle: 'مستشفى باب الشعرية (سيد جلال)',
      infoWindowDescription: ',0225893754,3766+222، Al Shareaa Al Gadid، العدوي، باب الشعرية, العدوي، محافظة القاهرة 4330360',
      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '21',
      markerPosition: const LatLng(
          30.06833436735362, 31.29338304819735),
      infoWindowTitle: 'مستشفى الامراض الصدرية بالعباسية',
      infoWindowDescription: 'العباسية، 6 السكة البيضاء، ABBASSEYA، مدينة نصر، محافظة القاهرة,0223425245,',
      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '22',
      markerPosition: const LatLng(
          30.602608831652418, 31.482351105606053 ),

      infoWindowTitle: 'بنك الدم مستشفى جامعه الزقازيق',
      infoWindowDescription: 'HFMP+JW9، شيبة النكارية، مركز الزقازيق، الشرقية 7120001',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '23',
      markerPosition: const LatLng(
          30.030469867303026, 31.23626741984464),

      infoWindowTitle: 'مستشفى أطفال مصر',
      infoWindowDescription: ',01004244428,1 Abu el reesh، ميدان، السيدة زينب، محافظة القاهرة‬',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '24',
      markerPosition: const LatLng(
          30.069819962462216, 31.294815243074865),

      infoWindowTitle: 'مستشفى حميات العباسية',
      infoWindowDescription: ',0223424025,El-Abaseya، إمتداد رمسيس، السريات الشرقية،، مدينة نصر',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '25',
      markerPosition: const LatLng(
          30.02058282917547, 32.54624379111682),

      infoWindowTitle: 'المركز الاقليمي لنقل الدم بالسويس',
      infoWindowDescription: 'XG8W+XX2، الشهداء، السويس،، السويس',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '26',
      markerPosition: const LatLng(
          29.988970802929213, 31.272705680432043),

      infoWindowTitle: 'مستشفى الياسمين بالمعادي - Yasmeen Hospital Al Maadi',
      infoWindowDescription: ',01014111130,X7MF+J37، الجزائر، معادي السرايات الغربية، قسم البساتين، محافظة القاهرة 4234501',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '27',
      markerPosition: const LatLng(
          30.0346310683986, 31.2268260439908),

      infoWindowTitle: 'مستشفيات جامعة القاهرة',
      infoWindowDescription: ',0223643988,26JG+JRF، قسم مصر القديمة، محافظة القاهرة 4240310',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '28',
      markerPosition: const LatLng(
          30.05152250319907, 31.26607451475684),

      infoWindowTitle: 'مستشفى الحسين التخصصي',
      infoWindowDescription: 'جوهر القائد، Ad، الدرب الأحمر، محافظة القاهرة ,01020186351,4293076',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '29',
      markerPosition: const LatLng(
          30.084496646151642, 31.28966540160409),

      infoWindowTitle: 'مستشفى عين شمس التخصصي',
      infoWindowDescription: 'الخليفة المأمون، كوبري القبة، قسم مصر الجديدة، محافظة القاهرة ,01098106892,4393002',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '30',
      markerPosition: const LatLng(
          31.286739379431644, 29.91112654199217 ),

      infoWindowTitle: 'المركز الاقليمى لنقل الدم بالاسكندرية',
      infoWindowDescription: '63 أحمد سليمان الشيخ، كوم الدكة شرق، العطارين، الإسكندرية ,034951963,5370055',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '31',
      markerPosition: const LatLng(
          31.278235682989365, 29.91661969759209 ),

      infoWindowTitle: 'بنك الدم',
      infoWindowDescription: 'مستشفي الجامعة، باب شرقي ووابور المياه، قسم باب شرقي، الإسكندرية ,01281813497,5422023',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '33',
      markerPosition: const LatLng(
          31.32799950109503, 29.955071683502787),

      infoWindowTitle: 'بنك الدم بالشاطبي',
      infoWindowDescription: ',034871586,6XP2+M7H، طريق الجيش، الأزاريتة والشاطبي، قسم باب شرقي، الإسكندرية 5452041',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '34',
      markerPosition: const LatLng(
          31.075047782730014, 31.363274801800014),

      infoWindowTitle: 'بنك دم _ مستشفى الجامعة',
      infoWindowDescription: '29V7+5MM، اول المنصورة،، اول المنصورة، الدقهلية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '35',
      markerPosition: const LatLng(
          30.027932405096088, 31.23094591709254),

      infoWindowTitle: 'المعهد القومي للأورام',
      infoWindowDescription: '1 شارع القصر العيني، ميدان فم الخليج، العيني، قسم السيدة زينب، محافظة القاهرة,0223664690,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '36',
      markerPosition: const LatLng(
          30.144562212053618, 31.355737632984656 ),

      infoWindowTitle: 'مستشفى عين شمس العام',
      infoWindowDescription: '49J4+V7R، عين شمس الشرقية، قسم عين شمس، محافظة القاهرة 4545245',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '37',
      markerPosition: const LatLng(
          30.03329355852859, 31.23094591709066 ),

      infoWindowTitle: 'مستشفى قصر العيني التعليمي الجديد',
      infoWindowDescription: 'كورنيش النيل، العيني، قسم السيدة زينب، محافظة القاهرة ,0223654061,4262001',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '39',
      markerPosition: const LatLng(
          30.640302483584918, 32.28745098043834),

      infoWindowTitle: 'المركز الإقليمى لخدمات نقل الدم بالإسماعيلية',
      infoWindowDescription: 'البحيرة، قسم ثان الاسماعيلية، الإسماعيلية 41517,0643103835,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '40',
      markerPosition: const LatLng(
          30.147730114465325, 31.385083586592234 ),

      infoWindowTitle: 'Saudi German Hospital Cairo المستشفي السعودي الألماني القاهرة',
      infoWindowDescription: 'محور طه حسين، الهايكستب، قسم النزهة، محافظة القاهرة 4473303',

      icon: BitmapDescriptor.defaultMarker,
    );

    ////

    AppCubit.get(context).addBloodMarker(
      markerId: '41',
      markerPosition: const LatLng(
          30.033671660663572, 31.227995197038087 ),

      infoWindowTitle: 'مستشفى قصر العيني',
      infoWindowDescription: 'جزيرة,0223643524,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '42',
      markerPosition: const LatLng(
          29.081860672402183, 31.121403769913048),

      infoWindowTitle: 'بنك الدم الاقليمى بنى سويف',
      infoWindowDescription: '24R9+Q8M، قسم بني سويف، مركز بنى سويف، محافظة بني سويف 2731016',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '43',
      markerPosition: const LatLng(
          29.089061350144544, 31.12415035175445),

      infoWindowTitle: 'المركز القليمى لنقل الدم ببنى سويف',
      infoWindowDescription: ',0822245151,24R9+R97، قسم بني سويف، بياض العرب، مركز بنى سويف، محافظة بني سويف 2731016',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '44',
      markerPosition: const LatLng(
          30.098493746618168, 31.328491733014516),

      infoWindowTitle: 'مستشفى كليوباترا',
      infoWindowDescription: ',0224143931,39 Cleopatra Street, Opposite Maidan Salahuddin Square، الماظة، قسم مصر الجديدة',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '45',
      markerPosition: const LatLng(
          31.28518249059463, 29.894647072060863),

      infoWindowTitle: 'مركز التبرع بالبلازما الأسكندرية',
      infoWindowDescription: ',01551978533,5WW5+9MQ، الإسكندرية،، غرب، العطارين،، الإسكندرية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '46',
      markerPosition: const LatLng(
          30.09881289972861, 31.291096016095015),

      infoWindowTitle: 'مستشفى الأمل التخصصي',
      infoWindowDescription: 'عرفات، الوايلي الكبير شرق، قسم حدائق القبة، محافظة القاهرة ,0224531119,4382542',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '47',
      markerPosition: const LatLng(
          30.558768964685054, 31.24876563277087 ),

      infoWindowTitle: 'المركز الإقليمى لنقل الدم ببنها فرع أسنيت',
      infoWindowDescription: 'G6HX+PG3، أسنيت، مركز كفر شكر، القليوبية 6491644',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '48',
      markerPosition: const LatLng(
          30.235665930534893, 31.481944237700983),

      infoWindowTitle: 'مستشفى فريد حبيب',
      infoWindowDescription: 'مستشفى فريد حبيب الحى الخامس قطعة رقم 5 بلوك 16081, قطعة رقم 5 Rock Ville Rd, العبور، القليوبية,0246142000,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '49',
      markerPosition: const LatLng(
          30.013448219960967, 32.54075066026421 ),

      infoWindowTitle: 'المركز الاقليمي لنقل الدم بالسويس',
      infoWindowDescription: 'XG8W+XX2، الشهداء، السويس،، السويس',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '50',
      markerPosition: const LatLng(
          28.175775838893017, 30.77265313647568 ),

      infoWindowTitle: 'المركز الإقليمى لنقل الدم بالمنيا',
      infoWindowDescription: 'كورنيش النيل بجوار مركز أورام المنيا Al menya, المنيا,0862339241,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '51',
      markerPosition: const LatLng(
          31.098290159302742, 31.368768004540723 ),

      infoWindowTitle: 'مركز الأورام جامعة المنصورة',
      infoWindowDescription: 'جيهان السادات، اول المنصورة، الدقهلية 7650030,0502202945,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '52',
      markerPosition: const LatLng(
          29.97783114756183, 32.550467211782376 ),

      infoWindowTitle: 'مستشفى السويس العام',
      infoWindowDescription: 'Salah Uddin St، السويس، 8141210,0623331190,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '53',
      markerPosition: const LatLng(
          30.072568428449916, 31.276650851960085 ),

      infoWindowTitle: 'بنك الدم الرئيسي - عين شمس',
      infoWindowDescription: '379G+64V، ممر خاص مستشفى الدمرداش، العباسية القبلية، الوايلى، محافظة القاهرة 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '54',
      markerPosition: const LatLng(
          30.589537635318045, 31.00670549709788 ),

      infoWindowTitle: 'مستشفى شبين الكوم التعليمي',
      infoWindowDescription: 'Gamal Abdel Nasser St، قسم شبين الكوم، المنوفية 6132703,0482221277,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '55',
      markerPosition: const LatLng(
          25.392690598608382, 46.63273463437496),

      infoWindowTitle: 'بنك الدم بمستشفى مدينة الملك سعود الطبية',
      infoWindowDescription: 'JMHQ+5WF، شارع الإمام عبدالعزيز بن محمد بن سعود الفرعي، عليشة، shemisee, الرياض 12746، المملكة العربية السعودية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '56',
      markerPosition: const LatLng(
          30.819614617122227, 30.998463967644348),

      infoWindowTitle: 'مستشفى المنشاوى العام',
      infoWindowDescription: 'شارع مستشفي المنشاوي، طنطا (قسم 2)، طنطا،، الغربية',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '58',
      markerPosition: const LatLng(
          26.78497064798173, 31.787543788537988),

      infoWindowTitle: 'بنك الدم الاقليمي بسوهاج',
      infoWindowDescription: 'GPQ4+99P، الخولي، قسم أول سوهاج، سوهاج 1670032,0932155381,',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addBloodMarker(
      markerId: '59',
      markerPosition: const LatLng(
          25.92936795138513, 32.852973613703305),

      infoWindowTitle: 'مستشفى شفاء الأورمان Shefaa Al Orman Hospital',
      infoWindowDescription: 'طيبة، مدينة طيبة الجديدة بجوار جهاز مدينة طيبة',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '60',
      markerPosition: const LatLng(
          30.99524147009114, 31.71881841207787),

      infoWindowTitle: 'مستشفى أولاد صقر المركزي',
      infoWindowDescription: 'قرية الزنانيرى، أولاد صقر، مركز أولاد صقر، الشرقية 7362860,0553464636,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '61',
      markerPosition: const LatLng(
          30.31647014595019, 31.743196960386587 ),

      infoWindowTitle: 'مصر سكوب لتجهيز سيارات الاسعاف',
      infoWindowDescription: 'قطعة 200 جنوب غرب 6 ا المنطقة الصناعية الثالثة, الشرقية ,01020010679,44634',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '62',
      markerPosition: const LatLng(
          30.585341380706012, 31.49883788802093 ),

      infoWindowTitle: 'المركز الاقليمى لنقل الدم بالزقازيق',
      infoWindowDescription: 'HG82+JGR، طريق الأحرار، مركز الزقازيق، الشرقية 7141360',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '63',
      markerPosition: const LatLng(
          27.33111817013578, 31.206331644086358 ),

      infoWindowTitle: 'Assiut Regional Blood Transfusion Center المركز الإقليمي لنقل الدم فرع أسيوط',
      infoWindowDescription: ',0882370016,55HJ+QPC، الطريق الدائري، الحمراء الثانية، قسم ثان أسيوط، أسيوط 2073021',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '64',
      markerPosition: const LatLng(
          30.03383715734181, 31.43728258160833  ),

      infoWindowTitle: 'Health Care City',
      infoWindowDescription: '90 التسعين الشمالي، قسم أول القاهرة الجديدة، محافظة القاهرة ,0228124242,4730131',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '65',
      markerPosition: const LatLng(
          30.074351063771537, 31.275756983685152),

      infoWindowTitle: 'بنك الدم الرئيسي - عين شمس',
      infoWindowDescription: '379G+64V، ممر خاص مستشفى الدمرداش، العباسية القبلية، الوايلى، محافظة القاهرة 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '66',
      markerPosition: const LatLng(
          30.04357842265291, 31.21672725544704 ),

      infoWindowTitle: 'مستشفى د. محمد الشبراويشى',
      infoWindowDescription: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '67',
      markerPosition: const LatLng(
          31.24454271564153, 29.920350270551847),

      infoWindowTitle: 'بنك الدم فرع كوم الدكة',
      infoWindowDescription: 'كوم الدكة غرب، العطارين، الإسكندرية 5370055,034951963,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addBloodMarker(
      markerId: '68',
      markerPosition: const LatLng(
          31.090402009976852, 31.382500878474165 ),
      infoWindowTitle: 'بنك الدم المنصورة الشيخ حسنين',
      infoWindowDescription: '29RH+CFQ، رقم 1، المنصورة (قسم 2)، المنصورة، الدقهلية 7652110,0502396781,',
      icon: BitmapDescriptor.defaultMarker,
    );
  }
  void addHomeMarkers(context) {

    AppCubit.get(context).addHomeMarker(
        markerId: '1',
        markerPosition: const LatLng(30.05160665975826, 31.21054654046658),
        infoWindowTitle:'المركز القومى لنقل الدم',
        infoWindowDescription: 'العجوزة، حي العجوزة، الجيزة 3753530'
    );
    AppCubit.get(context).addHomeMarker(
        markerId: '2',
        markerPosition: const LatLng(30.070037976343123, 31.284155908532693),
        infoWindowTitle: 'المركز الإقليمي لنقل الدم بالعباسية',
        infoWindowDescription: ' امام, مدرسة '
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '3',
      markerPosition: const LatLng(30.015734113461725, 31.22772343015096),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
      infoWindowDescription: 'استكشاف المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '4',
      markerPosition: const LatLng(30.043390224368093, 31.217853117984525),
      infoWindowTitle: 'مركز نقل الدم بمستشفى الدكتور مجدى',
      infoWindowDescription: 'شارع بولس حنا، الدقي قسم، قسم الدقي، الجيزة 3753410',
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '5',
      markerPosition: const LatLng(30.065843713162607, 31.244354625377646),
      infoWindowTitle: 'بنك الدم المركزى',
      infoWindowDescription: ' الهلال الأحمر المصري، الجيارة، الأزبكية، محافظة القاهرة 4320151',
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '6',
      markerPosition: const LatLng(30.05192076644373, 31.211052163215275),
      infoWindowTitle: 'المركز القومى لنقل الدم National Blood Transfusion Center, 26X6+MCG',
      infoWindowDescription: 'العجوزة، العمرانية, الجيزة 3753530',
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '7',
      markerPosition: const LatLng(30.04484433519289, 31.210344506356613),

      infoWindowTitle: 'مركز نقل الدم ومشتقاته بمستشفي الزراعيين',
      infoWindowDescription: '26R6+W57، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة 3751254',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '8',
      markerPosition: const LatLng(30.037857242715162, 31.209218132614158),
      infoWindowTitle: 'المركز القومى لنقل الدم',
      infoWindowDescription: ',26M6+P4 قسم الدقي,15 May Bridge، الدكتور السبكي',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '9',
      markerPosition: const LatLng(30.05212242683355, 31.211021180236536),
      infoWindowTitle: 'بنك الدم السويسري، المستشفي السويسري',
      infoWindowDescription: ',0237613117، العجوزة، حي العجوزة، الجيزة 3753530',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '10',
      markerPosition: const LatLng(30.054054012579744, 31.210334534735367),
      infoWindowTitle: 'المركز القومى لنقل الدم',
      infoWindowDescription: 'البطل أحمد عبد العزيز امام بنك hsbc,، العمرانية، الجيزة,0233374317',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '11',
      markerPosition: const LatLng(30.045155859720996, 31.23022679471311),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم',
      infoWindowDescription: '987 كورنيش النيل، باب اللوق، عابدين، محافظة القاهرة 4272040',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '12',
      markerPosition: const LatLng(30.07346400739051, 31.28485888329649),
      infoWindowTitle: 'بنك الدم الاقليمي',
      infoWindowDescription: '378M+9X5، Unnamed Road, السرايات، الوايلى،، الوايلى، محافظة القاهرة',
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '13',
      markerPosition: const LatLng(30.02323041387819, 31.237252230235853),
      infoWindowTitle: 'بنك الدم 57357',
      infoWindowDescription: ',0225351500,Children Canser Hospital, زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '14',
      markerPosition: const LatLng(30.073166901070287, 31.281462942806964),
      infoWindowTitle: 'Greek Hospital Blood Bank :: بنك الدم المستشفى اليوناني',
      infoWindowDescription: '15 شارع السرايات, العباسية,0226836668',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '15',
      markerPosition: const LatLng(30.025424652831912, 31.237583933650427),
      infoWindowTitle: 'مستشفى سرطان الاطفال 57357',
      infoWindowDescription: ',0225351500,سكة حديد المحجر، زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '16',
      markerPosition: const LatLng(30.029817886746002, 31.232273542392065),
      infoWindowTitle: 'جمعية اصدقاء المبادرة القومية ضد السرطان',
      infoWindowDescription: '33 القصر العيني، العيني، قسم السيدة زينب، محافظة القاهرة,4260016,0225353040,',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '17',
      markerPosition: const LatLng(30.044517238506575, 31.210157081923427),
      infoWindowTitle: 'مستشفى الزراعيين',
      infoWindowDescription: '1 ش النهضة بجوار وزارة الزراعة، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة,0233377677',
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '18',
      markerPosition: const LatLng(30.605758347137343, 31.006484897177497),
      infoWindowTitle: 'المركز الاقليمى لنقل الدم بشبين الكوم',
      infoWindowDescription: 'H2F6+VR2،,0482331379,قسم شبين الكوم، المنوفية 6132703',
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '19',
      markerPosition: const LatLng(30.025721902404115, 31.237927256401008),
      infoWindowTitle: 'مستشفى د. محمد الشبراويشى',
      infoWindowDescription: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444',
    );


    AppCubit.get(context).addHomeMarker(
      markerId: '20',
      markerPosition: const LatLng(
          30.06389801557521, 31.259661948463698 ),

      infoWindowTitle: 'مستشفى باب الشعرية (سيد جلال)',
      infoWindowDescription: ',0225893754,3766+222، Al Shareaa Al Gadid، العدوي، باب الشعرية, العدوي، محافظة القاهرة 4330360',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '21',
      markerPosition: const LatLng(
          30.06833436735362, 31.29338304819735),

      infoWindowTitle: 'مستشفى الامراض الصدرية بالعباسية',
      infoWindowDescription: 'العباسية، 6 السكة البيضاء، ABBASSEYA، مدينة نصر، محافظة القاهرة,0223425245,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '22',
      markerPosition: const LatLng(
          30.602608831652418, 31.482351105606053 ),

      infoWindowTitle: 'بنك الدم مستشفى جامعه الزقازيق',
      infoWindowDescription: 'HFMP+JW9، شيبة النكارية، مركز الزقازيق، الشرقية 7120001',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '23',
      markerPosition: const LatLng(
          30.030469867303026, 31.23626741984464),

      infoWindowTitle: 'مستشفى أطفال مصر',
      infoWindowDescription: ',01004244428,1 Abu el reesh، ميدان، السيدة زينب، محافظة القاهرة‬',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '24',
      markerPosition: const LatLng(
          30.069819962462216, 31.294815243074865),

      infoWindowTitle: 'مستشفى حميات العباسية',
      infoWindowDescription: ',0223424025,El-Abaseya، إمتداد رمسيس، السريات الشرقية،، مدينة نصر',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '25',
      markerPosition: const LatLng(
          30.02058282917547, 32.54624379111682),

      infoWindowTitle: 'المركز الاقليمي لنقل الدم بالسويس',
      infoWindowDescription: 'XG8W+XX2، الشهداء، السويس،، السويس',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '26',
      markerPosition: const LatLng(
          29.988970802929213, 31.272705680432043),

      infoWindowTitle: 'مستشفى الياسمين بالمعادي - Yasmeen Hospital Al Maadi',
      infoWindowDescription: ',01014111130,X7MF+J37، الجزائر، معادي السرايات الغربية، قسم البساتين، محافظة القاهرة 4234501',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '27',
      markerPosition: const LatLng(
          30.0346310683986, 31.2268260439908),

      infoWindowTitle: 'مستشفيات جامعة القاهرة',
      infoWindowDescription: ',0223643988,26JG+JRF، قسم مصر القديمة، محافظة القاهرة 4240310',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '28',
      markerPosition: const LatLng(
          30.05152250319907, 31.26607451475684),

      infoWindowTitle: 'مستشفى الحسين التخصصي',
      infoWindowDescription: 'جوهر القائد، Ad، الدرب الأحمر، محافظة القاهرة ,01020186351,4293076',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '29',
      markerPosition: const LatLng(
          30.084496646151642, 31.28966540160409),

      infoWindowTitle: 'مستشفى عين شمس التخصصي',
      infoWindowDescription: 'الخليفة المأمون، كوبري القبة، قسم مصر الجديدة، محافظة القاهرة ,01098106892,4393002',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '30',
      markerPosition: const LatLng(
          31.286739379431644, 29.91112654199217 ),

      infoWindowTitle: 'المركز الاقليمى لنقل الدم بالاسكندرية',
      infoWindowDescription: '63 أحمد سليمان الشيخ، كوم الدكة شرق، العطارين، الإسكندرية ,034951963,5370055',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '31',
      markerPosition: const LatLng(
          31.278235682989365, 29.91661969759209 ),

      infoWindowTitle: 'بنك الدم',
      infoWindowDescription: 'مستشفي الجامعة، باب شرقي ووابور المياه، قسم باب شرقي، الإسكندرية ,01281813497,5422023',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '33',
      markerPosition: const LatLng(
          31.32799950109503, 29.955071683502787),

      infoWindowTitle: 'بنك الدم بالشاطبي',
      infoWindowDescription: ',034871586,6XP2+M7H، طريق الجيش، الأزاريتة والشاطبي، قسم باب شرقي، الإسكندرية 5452041',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '34',
      markerPosition: const LatLng(
          31.075047782730014, 31.363274801800014),

      infoWindowTitle: 'بنك دم _ مستشفى الجامعة',
      infoWindowDescription: '29V7+5MM، اول المنصورة،، اول المنصورة، الدقهلية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '35',
      markerPosition: const LatLng(
          30.027932405096088, 31.23094591709254),

      infoWindowTitle: 'المعهد القومي للأورام',
      infoWindowDescription: '1 شارع القصر العيني، ميدان فم الخليج، العيني، قسم السيدة زينب، محافظة القاهرة,0223664690,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '36',
      markerPosition: const LatLng(
          30.144562212053618, 31.355737632984656 ),

      infoWindowTitle: 'مستشفى عين شمس العام',
      infoWindowDescription: '49J4+V7R، عين شمس الشرقية، قسم عين شمس، محافظة القاهرة 4545245',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '37',
      markerPosition: const LatLng(
          30.03329355852859, 31.23094591709066 ),

      infoWindowTitle: 'مستشفى قصر العيني التعليمي الجديد',
      infoWindowDescription: 'كورنيش النيل، العيني، قسم السيدة زينب، محافظة القاهرة ,0223654061,4262001',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '39',
      markerPosition: const LatLng(
          30.640302483584918, 32.28745098043834),

      infoWindowTitle: 'المركز الإقليمى لخدمات نقل الدم بالإسماعيلية',
      infoWindowDescription: 'البحيرة، قسم ثان الاسماعيلية، الإسماعيلية 41517,0643103835,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '40',
      markerPosition: const LatLng(
          30.147730114465325, 31.385083586592234 ),

      infoWindowTitle: 'Saudi German Hospital Cairo المستشفي السعودي الألماني القاهرة',
      infoWindowDescription: 'محور طه حسين، الهايكستب، قسم النزهة، محافظة القاهرة 4473303',

      icon: BitmapDescriptor.defaultMarker,
    );
    ////
    AppCubit.get(context).addHomeMarker(
      markerId: '41',
      markerPosition: const LatLng(
          30.033671660663572, 31.227995197038087 ),

      infoWindowTitle: 'مستشفى قصر العيني',
      infoWindowDescription: 'جزيرة,0223643524,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '42',
      markerPosition: const LatLng(
          29.081860672402183, 31.121403769913048),

      infoWindowTitle: 'بنك الدم الاقليمى بنى سويف',
      infoWindowDescription: '24R9+Q8M، قسم بني سويف، مركز بنى سويف، محافظة بني سويف 2731016',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '43',
      markerPosition: const LatLng(
          29.089061350144544, 31.12415035175445),

      infoWindowTitle: 'المركز القليمى لنقل الدم ببنى سويف',
      infoWindowDescription: ',0822245151,24R9+R97، قسم بني سويف، بياض العرب، مركز بنى سويف، محافظة بني سويف 2731016',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '44',
      markerPosition: const LatLng(
          30.098493746618168, 31.328491733014516),

      infoWindowTitle: 'مستشفى كليوباترا',
      infoWindowDescription: ',0224143931,39 Cleopatra Street, Opposite Maidan Salahuddin Square، الماظة، قسم مصر الجديدة',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '45',
      markerPosition: const LatLng(
          31.28518249059463, 29.894647072060863),

      infoWindowTitle: 'مركز التبرع بالبلازما الأسكندرية',
      infoWindowDescription: ',01551978533,5WW5+9MQ، الإسكندرية،، غرب، العطارين،، الإسكندرية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '46',
      markerPosition: const LatLng(
          30.09881289972861, 31.291096016095015),

      infoWindowTitle: 'مستشفى الأمل التخصصي',
      infoWindowDescription: 'عرفات، الوايلي الكبير شرق، قسم حدائق القبة، محافظة القاهرة ,0224531119,4382542',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '47',
      markerPosition: const LatLng(
          30.558768964685054, 31.24876563277087 ),

      infoWindowTitle: 'المركز الإقليمى لنقل الدم ببنها فرع أسنيت',
      infoWindowDescription: 'G6HX+PG3، أسنيت، مركز كفر شكر، القليوبية 6491644',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '48',
      markerPosition: const LatLng(
          30.235665930534893, 31.481944237700983),

      infoWindowTitle: 'مستشفى فريد حبيب',
      infoWindowDescription: 'مستشفى فريد حبيب الحى الخامس قطعة رقم 5 بلوك 16081, قطعة رقم 5 Rock Ville Rd, العبور، القليوبية,0246142000,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '49',
      markerPosition: const LatLng(
          30.013448219960967, 32.54075066026421 ),

      infoWindowTitle: 'المركز الاقليمي لنقل الدم بالسويس',
      infoWindowDescription: 'XG8W+XX2، الشهداء، السويس،، السويس',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '50',
      markerPosition: const LatLng(
          28.175775838893017, 30.77265313647568 ),

      infoWindowTitle: 'المركز الإقليمى لنقل الدم بالمنيا',
      infoWindowDescription: 'كورنيش النيل بجوار مركز أورام المنيا Al menya, المنيا,0862339241,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '51',
      markerPosition: const LatLng(
          31.098290159302742, 31.368768004540723 ),

      infoWindowTitle: 'مركز الأورام جامعة المنصورة',
      infoWindowDescription: 'جيهان السادات، اول المنصورة، الدقهلية 7650030,0502202945,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '52',
      markerPosition: const LatLng(
          29.97783114756183, 32.550467211782376 ),

      infoWindowTitle: 'مستشفى السويس العام',
      infoWindowDescription: 'Salah Uddin St، السويس، 8141210,0623331190,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '53',
      markerPosition: const LatLng(
          30.072568428449916, 31.276650851960085 ),

      infoWindowTitle: 'بنك الدم الرئيسي - عين شمس',
      infoWindowDescription: '379G+64V، ممر خاص مستشفى الدمرداش، العباسية القبلية، الوايلى، محافظة القاهرة 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '54',
      markerPosition: const LatLng(
          30.589537635318045, 31.00670549709788 ),

      infoWindowTitle: 'مستشفى شبين الكوم التعليمي',
      infoWindowDescription: 'Gamal Abdel Nasser St، قسم شبين الكوم، المنوفية 6132703,0482221277,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '55',
      markerPosition: const LatLng(
          25.392690598608382, 46.63273463437496),

      infoWindowTitle: 'بنك الدم بمستشفى مدينة الملك سعود الطبية',
      infoWindowDescription: 'JMHQ+5WF، شارع الإمام عبدالعزيز بن محمد بن سعود الفرعي، عليشة، shemisee, الرياض 12746، المملكة العربية السعودية',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '56',
      markerPosition: const LatLng(
          30.819614617122227, 30.998463967644348),

      infoWindowTitle: 'مستشفى المنشاوى العام',
      infoWindowDescription: 'شارع مستشفي المنشاوي، طنطا (قسم 2)، طنطا،، الغربية',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '58',
      markerPosition: const LatLng(
          26.78497064798173, 31.787543788537988),

      infoWindowTitle: 'بنك الدم الاقليمي بسوهاج',
      infoWindowDescription: 'GPQ4+99P، الخولي، قسم أول سوهاج، سوهاج 1670032,0932155381,',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addHomeMarker(
      markerId: '59',
      markerPosition: const LatLng(
          25.92936795138513, 32.852973613703305),

      infoWindowTitle: 'مستشفى شفاء الأورمان Shefaa Al Orman Hospital',
      infoWindowDescription: 'طيبة، مدينة طيبة الجديدة بجوار جهاز مدينة طيبة',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '60',
      markerPosition: const LatLng(
          30.99524147009114, 31.71881841207787),

      infoWindowTitle: 'مستشفى أولاد صقر المركزي',
      infoWindowDescription: 'قرية الزنانيرى، أولاد صقر، مركز أولاد صقر، الشرقية 7362860,0553464636,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '61',
      markerPosition: const LatLng(
          30.31647014595019, 31.743196960386587 ),

      infoWindowTitle: 'مصر سكوب لتجهيز سيارات الاسعاف',
      infoWindowDescription: 'قطعة 200 جنوب غرب 6 ا المنطقة الصناعية الثالثة, الشرقية ,01020010679,44634',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '62',
      markerPosition: const LatLng(
          30.585341380706012, 31.49883788802093 ),

      infoWindowTitle: 'المركز الاقليمى لنقل الدم بالزقازيق',
      infoWindowDescription: 'HG82+JGR، طريق الأحرار، مركز الزقازيق، الشرقية 7141360',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '63',
      markerPosition: const LatLng(
          27.33111817013578, 31.206331644086358 ),

      infoWindowTitle: 'Assiut Regional Blood Transfusion Center المركز الإقليمي لنقل الدم فرع أسيوط',
      infoWindowDescription: ',0882370016,55HJ+QPC، الطريق الدائري، الحمراء الثانية، قسم ثان أسيوط، أسيوط 2073021',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '64',
      markerPosition: const LatLng(
          30.03383715734181, 31.43728258160833  ),

      infoWindowTitle: 'Health Care City',
      infoWindowDescription: '90 التسعين الشمالي، قسم أول القاهرة الجديدة، محافظة القاهرة ,0228124242,4730131',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '65',
      markerPosition: const LatLng(
          30.074351063771537, 31.275756983685152),

      infoWindowTitle: 'بنك الدم الرئيسي - عين شمس',
      infoWindowDescription: '379G+64V، ممر خاص مستشفى الدمرداش، العباسية القبلية، الوايلى، محافظة القاهرة 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '66',
      markerPosition: const LatLng(
          30.04357842265291, 31.21672725544704 ),

      infoWindowTitle: 'مستشفى د. محمد الشبراويشى',
      infoWindowDescription: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '67',
      markerPosition: const LatLng(
          31.24454271564153, 29.920350270551847),

      infoWindowTitle: 'بنك الدم فرع كوم الدكة',
      infoWindowDescription: 'كوم الدكة غرب، العطارين، الإسكندرية 5370055,034951963,',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addHomeMarker(
      markerId: '68',
      markerPosition: const LatLng(
          31.090402009976852, 31.382500878474165 ),

      infoWindowTitle: 'بنك الدم المنصورة الشيخ حسنين',
      infoWindowDescription: '29RH+CFQ، رقم 1، المنصورة (قسم 2)، المنصورة، الدقهلية 7652110,0502396781,',

      icon: BitmapDescriptor.defaultMarker,
    );
  }
}

