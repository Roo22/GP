class TrainerModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? userType;
  String? location;
  int? lat;
  int? long;
  int? FirstProgram;
  int? SecondProgram;
  int? ThirdProgram;
  int? FourthProgram;
  int? FifthProgram;
  int? SixthProgram;
  int? SeventhProgram;
  int? EighthProgram;


  TrainerModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
    this.userType,
    this.location,
    this.lat,
    this.long,
    this.FirstProgram,
    this.SecondProgram,
    this.ThirdProgram,
    this.FourthProgram,
    this.FifthProgram,
    this.SixthProgram,
    this.SeventhProgram,
    this.EighthProgram,
  });

  TrainerModel.fromJson(Map<String,dynamic>? json)
  {
    email= json!['email'];
    phone= json['phone'];
    name= json['name'];
    uId= json['uId'];
    image= json['image'];
    cover= json['cover'];
    userType= json['userType'];
    location= json['location'];
    lat= json['lat'];
    long= json['long'];
    FirstProgram= json!['Lose Weight'];
    SecondProgram= json!['Gain Weight'];
    ThirdProgram= json!['Maintain Weight'];
    FourthProgram= json!['Gain Muscle'];
    FifthProgram=json!['Modify my diet'];
    SixthProgram=json!['Increase Step Count'];
    SeventhProgram=json!['Get Shredded'];
    EighthProgram=json!['Increase Strength'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'email':email,
      'phone': phone,
      'name':name,
      'uId':uId,
      'image':image,
      'cover':cover,
      'userType':userType,
      'location':location,
      'lat':lat,
      'long':long,
      'Lose Weight':FirstProgram,
      'Gain Weight': SecondProgram,
      'Maintain Weight':ThirdProgram,
      'Gain Muscle':FourthProgram,
      'Modify my diet':FifthProgram,
      'Increase Step Count':SixthProgram,
      'Get Shredded':SeventhProgram,
      'Increase Strength':EighthProgram,
    };
  }
}