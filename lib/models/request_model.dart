class RequestModel
{
 String? senderId;
 String? receiverId;
 String? dateTime;
 bool? isAccepted;
 String? bodyType;
 String? text;



 RequestModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.isAccepted,
    this.bodyType,
    this.text,
 });

 RequestModel.fromJson(Map<String,dynamic>? json)
 {
   senderId= json!['senderId'];
   receiverId= json['receiverId'];
   dateTime= json['dateTime'];
   isAccepted= json['isAccepted'];
   bodyType= json['bodyType'];
   text= json['text'];
 }

 Map<String,dynamic> toMap()
{
   return {
     'senderId':senderId,
     'receiverId': receiverId,
     'dateTime':dateTime,
     'isAccepted':isAccepted,
     'bodyType':bodyType,
     'text':text,
   };
}
}