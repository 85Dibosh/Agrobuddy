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
  String priceFlexibility = 'Fixed';
  TextEditingController availabilityController = TextEditingController(text: '1,200');
  TextEditingController costController = TextEditingController(text: '45');
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose(){ //to prevent memory leak and better efficiency
    availabilityController.dispose();
    costController.dispose();
    descriptionController.dispose();
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
              SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedCrop,
                      dropdownColor: Color(0xFF2E3B23),
                      icon: Icon(Icons.keyboard_arrow_down,color: Colors.white70),
                      style: TextStyle(fontSize: 16, color: Colors.white),

                      isExpanded: true,
                      onChanged: (val){
                        if (val != null) setState(() => selectedCrop = val);
                      },
                      items: cropOptions.map((crop){ // works like a for each loop
                        return DropdownMenuItem<String>(
                          value: crop, // this is for pc to retrieve the data
                          child: Text(crop), // to show text value in menu
                        );
                      }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              buildLabel('Farming Type'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: buildSegmentButton(
                        label: 'Organic',
                        icon: Icons.eco_outlined,
                        isSelected: farmingType == 'Organic',
                        onTap: (){
                          setState(() {
                            farmingType = 'Organic';
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: buildSegmentButton(
                        label: 'Hybrid',
                        icon: Icons.science_outlined,
                        isSelected: farmingType == 'Hybrid',
                        onTap: (){
                          setState(() {
                            farmingType = 'Hybrid';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildLabel('Availabilty (kg)'),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: availabilityController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Kg',
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildLabel('Cost per Kg'),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white,fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Tk',
                        style: TextStyle(
                          color: Color(0xFFD4A017),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        '/ kg',
                        style: TextStyle(color: Colors.white70,fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildLabel('Price Flexibility'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: buildSegmentButton(
                        label: 'Fixed',
                        icon: Icons.lock_outline,
                        isSelected: priceFlexibility == 'Fixed',
                        onTap: (){
                          setState(() {
                            priceFlexibility = 'Fixed';
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: buildSegmentButton(
                        label: 'Negotiable',
                        icon: Icons.handshake_outlined,
                        isSelected: priceFlexibility == 'Negotiable',
                        onTap: (){
                          setState(() {
                            priceFlexibility = 'Negotiable';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildLabel('Harvest Date'),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  style: TextStyle(color: Colors.white,fontSize: 15,height: 1.4),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Enter crop and harvest details...',
                    hintStyle: TextStyle(color: Colors.white38),
                  ),

                ),
              ),
              SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4A017),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Publish Listing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14201A),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
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