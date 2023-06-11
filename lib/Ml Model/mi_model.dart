import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/shared/components/custom_outline.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MIModel extends StatefulWidget {
  const MIModel({Key? key}) : super(key: key);

  @override
  State<MIModel> createState() => _MIModelState();
}

class _MIModelState extends State<MIModel> {
  String? result= ' ';
  final picker=ImagePicker();
  File? img;
  var url = "http://172.20.10.6:5000/predictApi";
  Future pickImageGal() async{
    PickedFile? pickedFile=(await picker.getImage(source: ImageSource.gallery));

    setState(() {
      img=File(pickedFile!.path);
    });
  }
  Future pickImageCam() async{
    PickedFile? pickedFile=(await picker.getImage(source: ImageSource.camera));

    setState(() {
      img=File(pickedFile!.path);
    });
  }
  upload () async{
    final request=http.MultipartRequest("POST",Uri.parse(url));
    final header={"Content_type": "multipart/form-data"};
    request.files.add(http.MultipartFile('fileup',img!.readAsBytes().asStream(),img!.lengthSync(),
        filename: img!.path.split('/').last));
    request.headers.addAll(header);
    final myRequest=await request.send();
    http.Response res=await http.Response.fromStream(myRequest);
    if(myRequest.statusCode==200){
      final resJson=jsonDecode(res.body);
      print("response here: $resJson");
      result=resJson['prediction'];
    }else
    {
      print("Error ${myRequest.statusCode}");
    }
    setState(() {

    });



  }
  void _fetchDataFromServer()async{
    final Dio dio = new Dio();

  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Food Classification'),
      ),
      body: SizedBox(
        height: ScreenHeight,
        width: ScreenWidth,
        child: Stack(
          children: [
            Positioned(
              top: ScreenHeight*0.1,
              left: -88,
              child: Container(
                height: 166,
                width: 166,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kLightFuchsiaColor
                ),
                child:BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200
                  ),
                ) ,
              ),
            ),
            Positioned(
              top: ScreenHeight*0.3,
              right: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constants.kDarkFuchsiaColor
                ),
                child:BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 200,
                      sigmaY: 200
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ) ,
              ),
            ),
            SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomOutline(
                        strokeWidth: 4,
                        radius: ScreenWidth * 0.10,
                        gradient:  LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kDarkFuchsiaColor,
                              Constants.kDarkFuchsiaColor.withOpacity(0),
                              Constants.kLightFuchsiaColor.withOpacity(0.1),
                              Constants.kLightFuchsiaColor
                            ],
                            stops: const [
                              0.2,
                              0.4,
                              0.6,
                              1
                            ]),
                        width: ScreenWidth * 0.56,
                        height: ScreenHeight * 0.26,
                        padding: const EdgeInsets.all(2),
                      child: Center(
                        child: img == null?
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenWidth * 0.10),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                  image:
                                  AssetImage('assets/gplogofinal.png')
                                 ,
                                ),

                              ),
                            ):
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenWidth * 0.10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              image:
                              FileImage(img!),
                            ),

                          ),
                        )

                      ),

                    ),
                    SizedBox(height: ScreenHeight*0.05,),
                    Center(
                        child: img==null?
                        Text('NOTHING HAS BEEN PREDICTED',textAlign: TextAlign.center,
                          style: TextStyle(color: Constants.kWhiteColor.withOpacity(0.85,),fontSize:  20,
                            fontWeight: FontWeight.w700,),
                        )
                            :
                        Text('Results : $result',textAlign: TextAlign.center,
                          style: TextStyle(color: Constants.kWhiteColor.withOpacity(0.85,),fontSize: 20,
                            fontWeight: FontWeight.w700,),
                        )

                    ),
                    SizedBox(height: ScreenHeight*0.03,),
                    CustomOutline(
                      strokeWidth: 3,
                      radius: 20,
                      padding: const EdgeInsets.all(3),
                      width: 160,
                      height: 38,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Constants.kDarkFuchsiaColor, Constants.kLightFuchsiaColor],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kDarkFuchsiaColor.withOpacity(0.5),
                              Constants.kLightFuchsiaColor.withOpacity(0.5)
                            ],
                          ),
                        ),
                        child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white12,),

                          ),
                          onPressed: (){
                            pickImageGal();
                          },
                          child: Text('Pick Image Here',style: TextStyle(
                            fontSize: 12,
                            color: Constants.kWhiteColor,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomOutline(
                      strokeWidth: 3,
                      radius: 20,
                      padding: const EdgeInsets.all(3),
                      width: 160,
                      height: 38,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Constants.kDarkFuchsiaColor, Constants.kLightFuchsiaColor],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kDarkFuchsiaColor.withOpacity(0.5),
                              Constants.kLightFuchsiaColor.withOpacity(0.5)
                            ],
                          ),
                        ),
                        child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white12,),

                          ),
                          onPressed: (){
                            pickImageCam();
                          },
                          child: Text('Take Image Here',style: TextStyle(
                            fontSize: 12,
                            color: Constants.kWhiteColor,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomOutline(
                      strokeWidth: 3,
                      radius: 20,
                      padding: const EdgeInsets.all(3),
                      width: 160,
                      height: 38,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Constants.kDarkFuchsiaColor, Constants.kLightFuchsiaColor],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kDarkFuchsiaColor.withOpacity(0.5),
                              Constants.kLightFuchsiaColor.withOpacity(0.5)
                            ],
                          ),
                        ),
                        child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white12,),

                          ),
                          onPressed: (){
                            upload();
                          },
                          child: Text('Upload Image',style: TextStyle(
                            fontSize: 12,
                            color: Constants.kWhiteColor,
                          )),
                        ),
                      ),
                    ),



                  ],
                ))
          ],
        ),

      )
    );
  }
}
