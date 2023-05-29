class DoctorRequest{
String userName="";
String userQuery="";

String img="";

DoctorRequest({required this.userName,required this.userQuery,required this.img});


}
class DoctorRequestData{
  List<DoctorRequest> doctor=[DoctorRequest(userName:"Nick",userQuery:"Donec vel mollis enim, vitae ultrices odio\nProin eu lacinia massa",img:"https://img.icons8.com/color/1x/user-female-circle.png"),
  DoctorRequest(userName:"Becky",userQuery:"Donec vel mollis enim, vitae ultrices odio\nProin eu lacinia massa",img:"https://img.icons8.com/color/1x/circled-user-female-skin-type-1-2--v1.png"),
  DoctorRequest(userName:"Will",userQuery:"Donec vel mollis enim, vitae ultrices odio\nProin eu lacinia massa",img:"https://img.icons8.com/color/1x/circled-user-female-skin-type-3.png"),
  DoctorRequest(userName:"Joe",userQuery:"Donec vel mollis enim, vitae ultrices odio\nProin eu lacinia massa",img:"https://img.icons8.com/color/1x/circled-user-female-skin-type-6.png"),
  DoctorRequest(userName:"Quinn",userQuery:"Donec vel mollis enim, vitae ultrices odio\nProin eu lacinia massa",img:"https://img.icons8.com/color/1x/circled-user-female-skin-type-7.png"),
];
}