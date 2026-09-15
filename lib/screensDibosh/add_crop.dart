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
    }

    @override
    Widget build(BuildContext context){
        
    }
}