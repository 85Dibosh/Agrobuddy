import 'package:flutter/material.dart';

class MyStorefrontScreen extends StatefulWidget{
  MyStorefrontScreen({super.key});

  @override
  State<MyStorefrontScreen> createState() => MyStorefrontScreenState();
}

class MyStorefrontScreenState extends State<MyStorefrontScreen>{
   int currentNavIndex = 1;

   List<Map<String,String>> cropList = [
     {
       'title' : 'Tomatoes',
       'price' : 'Tk45 / kg',
       'image' : 'assets/images/storefront/tomatoes.png',
     },
     {
       'title' : 'Organic Rice',
       'price' : 'Tk70 / kg',
       'image' : 'assets/images/storefront/rice.png',
     },
     {
       'title' : 'Green Chilli',
       'price' : 'Tk95 / kg',
       'image' : 'assets/images/storefront/chilli.png',
     },
   ];
   
   @override
  Widget build(BuildContext context){
     return Scaffold(
       backgroundColor: Color(0xFF14201A),

       //appbar
       appBar: AppBar(
         backgroundColor: Color(0xFF14201A),
         elevation: 0, // to remove the thin line between main screen and appbar
         leading: Container(
           margin: EdgeInsets.all(8),
           decoration: BoxDecoration(
             color: Color(0xFF1E2B22),
             shape: BoxShape.circle,
           ),

           child: IconButton(
             icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
             onPressed: (){
               Navigator.pop(context);
             },
           ),
         ),

         titleSpacing: 4, // to remove 4 pixels distance between AB and arrow
         title: Row(
           children: [
             Container(
               padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
               decoration: BoxDecoration(
                 color: Color(0xFFD4A017),
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Text(
                 'AB',
                 style: TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.bold,
                   color: Color(0xFF14201A),
                 ),
               ),
               
             ),
             SizedBox(width: 10),
             
             Text(
               'AgroBuddy',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.white,
                 fontFamily: 'serif',
               ),
             ),
           ],
         ),
         
         //actions
         actions: [
           Container(
             margin: EdgeInsets.only(right: 8),
             
             decoration: BoxDecoration(
               color: Color(0xFF1E2B22),
               shape: BoxShape.circle,
             ),

             child: IconButton(
               icon: Icon(Icons.notifications_none,color: Colors.white70,size: 20),
               onPressed: (){},
             ),
           ),
           Padding(
             padding: EdgeInsets.only(right: 16),
             child: CircleAvatar(
               radius: 18,
               backgroundImage: AssetImage('assets/images/avatar.png'),
             ),
           ),
         ],
       ),


     );
   }
}