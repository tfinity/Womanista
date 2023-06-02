class Doctor{
String Name="";
String Desc="";
var Rating=0.0 ;
String Img="";
String ProfileDesc="";
String Email="";
Doctor({required this.Name,required this.Desc,required this.Rating,required this.ProfileDesc, required this.Img,required this.Email});


}
class DoctorData{
  List<Doctor> doctor=[Doctor(Name:"Dr. Mary Jones",Desc:"Gynecologist",Rating:4.5,ProfileDesc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sapien turpis. \nDuis convallis pulvinar porta. Donec ex lorem, dignissim vel risus in, condimentum placerat metus. Mauris dictum in ante sed molestie. Pellentesque pretium eget ante vel consectetur. Donec vel mollis enim, vitae ultrices odio. Proin eu lacinia massa, a cursus dolor.",Img:"https://png.pngtree.com/png-vector/20220901/ourmid/pngtree-female-doctor-avatar-icon-illustration-png-image_6134280.png",Email:"Mary@gmail.com"),
Doctor(Name:"Dr. Olivia Smith",Desc:"Gynecologist",Rating:5.0,ProfileDesc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sapien turpis. \nDuis convallis pulvinar porta. Donec ex lorem, dignissim vel risus in, condimentum placerat metus. Mauris dictum in ante sed molestie. Pellentesque pretium eget ante vel consectetur. Donec vel mollis enim, vitae ultrices odio. Proin eu lacinia massa, a cursus dolor.",Img:"https://png.pngtree.com/png-vector/20220901/ourmid/pngtree-female-doctor-avatar-icon-illustration-png-image_6134280.png",Email:"Olivia@gmail.com"),
Doctor(Name:"Dr. Lily James",Desc:"Gynecologist",Rating:4.0,ProfileDesc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sapien turpis. \nDuis convallis pulvinar porta. Donec ex lorem, dignissim vel risus in, condimentum placerat metus. Mauris dictum in ante sed molestie. Pellentesque pretium eget ante vel consectetur. Donec vel mollis enim, vitae ultrices odio. Proin eu lacinia massa, a cursus dolor.",Img:"https://png.pngtree.com/png-vector/20220901/ourmid/pngtree-female-doctor-avatar-icon-illustration-png-image_6134280.png",Email:"Lily@gmail.com"),
Doctor(Name:"Dr. Sophia",Desc:"Gynecologist",Rating:3.5,ProfileDesc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sapien turpis. \nDuis convallis pulvinar porta. Donec ex lorem, dignissim vel risus in, condimentum placerat metus. Mauris dictum in ante sed molestie. Pellentesque pretium eget ante vel consectetur. Donec vel mollis enim, vitae ultrices odio. Proin eu lacinia massa, a cursus dolor.",Img:"https://png.pngtree.com/png-vector/20220901/ourmid/pngtree-female-doctor-avatar-icon-illustration-png-image_6134280.png",Email:"Sophia@gmail.com"),
Doctor(Name:"Dr. Isabella Raven",Desc:"Gynecologist",Rating:4.5,ProfileDesc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sapien turpis. \nDuis convallis pulvinar porta. Donec ex lorem, dignissim vel risus in, condimentum placerat metus. Mauris dictum in ante sed molestie. Pellentesque pretium eget ante vel consectetur. Donec vel mollis enim, vitae ultrices odio. Proin eu lacinia massa, a cursus dolor.",Img:"https://png.pngtree.com/png-vector/20220901/ourmid/pngtree-female-doctor-avatar-icon-illustration-png-image_6134280.png",Email:"Isabella@gmail.com"),

];
}