import 'package:agrobuddy/screensNishat/farmer_profile.dart';
import 'package:flutter/material.dart';
import 'package:agrobuddy/screensNishat/farmer_dashboard.dart';
import 'add_crop.dart';

class MyStorefrontScreen extends StatefulWidget{
  MyStorefrontScreen({super.key});

  @override
  State<MyStorefrontScreen> createState() => MyStorefrontScreenState();
}
class CropItem {
  final String title;
  final String price;
  final String imagePath;

  CropItem({
    required this.title,
    required this.price,
    required this.imagePath,
  });
}
class MyStorefrontScreenState extends State<MyStorefrontScreen>{
   int currentNavIndex = 1;

   List<CropItem> cropList = [
     CropItem(title: 'Tomatoes', price: 'Tk45 / kg', imagePath: 'assets/images/storefront/tomatoes.png'),
     CropItem(title: 'Organic Rice', price: 'Tk70 / kg', imagePath: 'assets/images/storefront/rice.png'),
     CropItem(title: 'Green Chilli', price: 'Tk95 / kg', imagePath: 'assets/images/storefront/chilli.png'),
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
                 shape: BoxShape.circle,
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
             margin: EdgeInsets.only(right: 16),
             decoration: BoxDecoration(
               color: Color(0xFF1E2B22),
               shape: BoxShape.circle,
             ),
             child: IconButton(
               icon: Icon(Icons.notifications_none, color: Colors.white70, size: 20),
               onPressed: () {},
             ),
           ),
         ],
       ),

       // body
       body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 'My Storefront',
                 style: TextStyle(
                   fontSize: 32,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                   fontFamily: 'serif',
                 ),
               ),
               SizedBox(height: 24),

               for(var crop in cropList) ...[
                 buildCropCard(crop),
                 SizedBox(height: 16),
               ],

               SizedBox(height: 8),

               //addCrop Button
               SizedBox(
                 width: double.infinity,
                 height: 54,
                 child: ElevatedButton(
                   onPressed: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => AddNewCropScreen(),
                       ),
                     );
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFFD4A017),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(28),
                     ),
                     elevation: 0,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.add,color: Color(0xFF14201A),size: 22),
                       SizedBox(width: 8),

                       Text(
                         'Add Crop',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                           color: Color(0xFF14201A),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 20),
             ],
           ),
         ),
       ),
        
       
       // bottom nav bar
       
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentNavIndex,
         onTap: (index){
           if (index == 0) {
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                 builder: (context) => FarmerDashboardScreen(),
               ),
             );
           } else if (index == 3) {
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => FarmerProfileScreen(),
               ),
             );
           } else {
             setState(() {
               currentNavIndex = index;
             });
           }
         },
         backgroundColor: Color(0xFF14201A),
         type: BottomNavigationBarType.fixed, // fixes tab positions
         selectedItemColor: Color(0xFFD4A017),
         unselectedItemColor: Color(0xFF8E9B90),

         selectedFontSize: 12,
         unselectedFontSize: 12,

         items: [
           BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.storefront),label: 'Market'),
           BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline),label: 'Chat'),
           BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: 'Profile'),
         ],
       ),
     );
   }
   
   Widget buildCropCard(CropItem crop){
     return Container(
       padding: EdgeInsets.all(14),
       decoration: BoxDecoration(
         color: Color(0xFF2E3B23),
         borderRadius: BorderRadius.circular(22),
       ),
       child: Row(
         children: [
           ClipRRect( //for rounded image (circular box, square image fix)
             borderRadius: BorderRadius.circular(16),
             child: Image.asset(
               crop.imagePath,
               width: 72,
               height: 72,
               fit: BoxFit.cover, //fills the image with the box
             ),
           ),
           SizedBox(width: 16),

           //crop title
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   crop.title,
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                     fontFamily: 'serif',
                   ),
                 ),
                 SizedBox(height: 6),
                 Text(
                   crop.price,
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Color(0xFFD4A017),
                   ),
                 ),
               ],
             ),
           ),

           //edit button
           Container(
              width: 40,
             height: 40,
             decoration: BoxDecoration(
               color: Color(0xFF222D1B),
               shape: BoxShape.circle,
             ),
             child: IconButton(
                 onPressed: (){},
                 icon: Icon(
                   Icons.edit_outlined,
                   color: Colors.white70,
                   size: 18,
                 )
             ),
           ),
         ],
       ),
     );
   }
}