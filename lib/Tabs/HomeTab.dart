import 'package:final_project/Screens/purchaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Database/sqlDB.dart';
import '../Ui/laptop_container.dart';
import '../Ui/phone_container.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<sqlDataBase>( // Use Consumer to listen to changes
      builder: (context, database, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Shop What Ever You Want .. ",
                      style: TextStyle(
                          color: Color(0xff344054),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                buildLaptopSection(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      "Best Offers ",
                      style: TextStyle(
                          color: Color(0xff344054),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                buildPhoneSection(),
                Row(
                  children: [
                    buildOrderesLaptopsContainer(),
                  ],
                ),
                Row(
                  children: [
                    buildOrderdPhonesContainer(),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, purchaseScreen.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Amount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${Constants.totalAmount}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Visibility buildOrderdPhonesContainer() {
    return Visibility(
                    visible: (Constants.phoneQuantity > 0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${Constants.phoneQuantity} IPhone Ordered",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Constants.phoneQuantity--;
                            Constants.totalAmount -= Constants.phonePrice;
                            setState(() {});
                          },
                          child: Text("Delete Item", style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                  );
  }

  Visibility buildOrderesLaptopsContainer() {
    return Visibility(
                    visible: (Constants.laptopQuantity > 0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${Constants.laptopQuantity} HP Laptop Ordered",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Constants.laptopQuantity--;
                            Constants.totalAmount -= Constants.laptopPrice;
                            setState(() {});
                          },
                          child: Text("Delete Item"),
                        )
                      ],
                    ),
                  );
  }

  SingleChildScrollView buildPhoneSection() {
    return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    phoneContainer(
                        onClick: onPhoneAddToCartClick,
                        iphonePrice: Constants.phonePrice),
                    phoneContainer(
                        onClick: onPhoneAddToCartClick,
                        iphonePrice: Constants.phonePrice),
                    phoneContainer(
                        onClick: onPhoneAddToCartClick,
                        iphonePrice: Constants.phonePrice),
                    phoneContainer(
                        onClick: onPhoneAddToCartClick,
                        iphonePrice: Constants.phonePrice),
                  ],
                ),
              );
  }

  SingleChildScrollView buildLaptopSection() {
    return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    laptopContainer(
                        onClick: onLaptopAddToCartClick,
                        laptopPrice: Constants.laptopPrice),
                    laptopContainer(
                        onClick: onLaptopAddToCartClick,
                        laptopPrice: Constants.laptopPrice),
                    laptopContainer(
                        onClick: onLaptopAddToCartClick,
                        laptopPrice: Constants.laptopPrice),
                    laptopContainer(
                        onClick: onLaptopAddToCartClick,
                        laptopPrice: Constants.laptopPrice),
                  ],
                ),
              );
  }

  void onLaptopAddToCartClick() {
    Constants.totalAmount += Constants.laptopPrice;
    Constants.laptopQuantity++;
    setState(() {});
  }

  void onPhoneAddToCartClick() {
    Constants.totalAmount += Constants.phonePrice;
    Constants.phoneQuantity++;
    setState(() {});
  }
}