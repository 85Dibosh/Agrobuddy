import 'package:flutter/material.dart';
import 'cart_checkout_empty_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, dynamic>> orderItems = [
    {
      'title': 'Roma Tomatoes',
      'seller': 'Rafiqul Islam',
      'rate': 42,
      'qty': 300,
    },
    {
      'title': 'Organic Boro Rice',
      'seller': 'Rafiqul Islam',
      'rate': 68,
      'qty': 150,
    },
  ];

  int selectedPaymentIndex = 0;

  int calculateGrandTotal() {
    int total = 0;
    for (var item in orderItems) {
      total += (item['qty'] as int) * (item['rate'] as int);
    }
    return total;
  }

  void removeItem(int index) {
    setState(() {
      orderItems.removeAt(index);
    });

    if (orderItems.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EmptyCartScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int grandTotal = calculateGrandTotal();

    return Scaffold(
      backgroundColor: Color(0xFF132018),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5A633),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'AB',
                              style: TextStyle(
                                color: Color(0xFF132018),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Review and finalize your produce purchase',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white60,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Dynamic list of items
                    for (int i = 0; i < orderItems.length; i++) ...[
                      buildItemCard(i),
                      SizedBox(height: 14),
                    ],

                    // Total Amount Box
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFF263326),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tk $grandTotal',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE5A633),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'DELIVERY ADDRESS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Colors.white60,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF263326),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color(0xFF334033),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xFFE5A633),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Central Hub, Dhanmondi, Dhaka',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Plot 42, Cold Storage Unit 3, Dhaka',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'PAYMENT METHOD',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Colors.white60,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentIndex = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Color(0xFF263326),
                                borderRadius: BorderRadius.circular(14),
                                border: selectedPaymentIndex == 0
                                    ? Border.all(color: Color(0xFFE5A633), width: 1.5)
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.account_balance_wallet_outlined, color: Color(0xFFE5A633), size: 24),
                                  SizedBox(height: 8),
                                  Text(
                                    'bKash / Nagad',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Color(0xFF263326),
                                borderRadius: BorderRadius.circular(14),
                                border: selectedPaymentIndex == 1
                                    ? Border.all(color: Color(0xFFE5A633), width: 1.5)
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.account_balance_outlined, color: Colors.white70, size: 24),
                                  SizedBox(height: 8),
                                  Text(
                                    'Bank Transfer',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentIndex = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Color(0xFF263326),
                                borderRadius: BorderRadius.circular(14),
                                border: selectedPaymentIndex == 2
                                    ? Border.all(color: Color(0xFFE5A633), width: 1.5)
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.shield_outlined, color: Colors.white70, size: 24),
                                  SizedBox(height: 8),
                                  Text(
                                    'Escrow Vault',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE5A633),
                    foregroundColor: Color(0xFF132018),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Order Placed for Tk $grandTotal!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemCard(int index) {
    var item = orderItems[index];
    int itemTotal = (item['qty'] as int) * (item['rate'] as int);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF263326),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['title'],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  removeItem(index);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, color: Colors.white54, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Tk ${item['rate']} / kg • Seller: ${item['seller']}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white60,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1B261D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.remove, color: Color(0xFFE5A633), size: 16),
                      onPressed: () {
                        if (item['qty'] > 10) {
                          setState(() {
                            item['qty'] = (item['qty'] as int) - 10;
                          });
                        }
                      },
                    ),
                    Text(
                      '${item['qty']} kg',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add, color: Color(0xFFE5A633), size: 16),
                      onPressed: () {
                        setState(() {
                          item['qty'] = (item['qty'] as int) + 10;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                'Tk $itemTotal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE5A633),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}