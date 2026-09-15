import 'dart:math';

import 'package:flutter/material.dart';

class AddNewCropScreen extends StatefulWidget{
  AddNewCropScreen({super.key});

  @override
  State<AddNewCropScreen> createState() => AddNewCropScreenState();
}

class AddNewCropScreenState extends State<AddNewCropScreen>{
    String selectedCrop = 'Tomatoes';

    List<String> cropOptions = [
      'Tomatoes',
      'Organic Rice',
      'Green Chilli',
    ];

    String farmingType = 'Organic';
    TextEditingController availabilityController = TextEditingController(text: '1,200');
    TextEditingController costController = TextEditingController(text: '45');
    TextEditingController dateController = TextEditingController(text: '17/09/2026');

    @override
    void dispose(){ //to prevent memory leak and better efficiency
      availabilityController.dispose();
      costController.dispose();
      dateController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Color(0xFF14201A),
        appBar: AppBar(
          backgroundColor: Color(0xFF14201A),
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),

            child: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,size: 20),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),

          titleSpacing: 0, // clear out the default 16pixels gap
          title: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Color(0xFFD4A017),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'AB',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF14201A),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Add New Crop',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crop Info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),

                buildLabel('Crop Type'),


              ],
            ),
          ),
        ),
      );
    }

    Widget buildLabel(String text){
      return Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      );
    }

    Widget buildSegmentButton({required String label,required IconData icon,required bool isSelected, required VoidCallback onTap}){
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFD4A017) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 18,color: isSelected ? Color(0xFF14201A) : Colors.white70),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isSelected ? Color(0xFF14201A) : Colors.white70,
                ),
              ),
            ],
          ),
        ),

      );
    }
}