import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MarketplaceScreen(),
  ));
}

class MarketplaceScreen extends StatefulWidget {
  MarketplaceScreen({Key? key}) : super(key: key);

  @override
  MarketplaceScreenState createState() => MarketplaceScreenState();
}

}