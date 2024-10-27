
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Database/sqlDB.dart';

class purchaseScreen extends StatefulWidget {
  static String routeName = "purchaseScreen";
  const purchaseScreen({super.key});

  @override
  State<purchaseScreen> createState() => _purchaseScreenState();
}

class _purchaseScreenState extends State<purchaseScreen> {
  late sqlDataBase database;
  int totalPhonesPrice = Constants.phonePrice * Constants.phoneQuantity;
  int totalLaptopsPrice = Constants.laptopPrice * Constants.laptopQuantity;

  @override
  Widget build(BuildContext context) {
    sqlDataBase database = Provider.of<sqlDataBase>(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {},
          child: Image(
            image: AssetImage(Constants.appBarIcon),
          ),
        ),
        title: Text(
          "Purchase",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {},
              child: Icon(Icons.more_vert, color: Colors.deepOrange))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Invoice Number : ${Constants.invoiceId}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          Constants.Date,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 10, thickness: 3, color: Colors.black),
                    Column(
                      children: [
                        Text(
                          "Total : ${Constants.totalAmount} ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 10, thickness: 3, color: Colors.black),
                    SizedBox(height: 10),
                    buildLaptopsDetails(totalLaptopsPrice),
                    Divider(height: 10, thickness: 1.5, color: Colors.black),
                    buildPhonesDetails(totalPhonesPrice),
                  ],
                ),
              ),
            ),
          ),
          buildPayButton(database, Constants.Date, context),
        ],
      ),
    );
  }

  Visibility buildPhonesDetails(int totalPhonesPrice) {
    return Visibility(
      visible: (Constants.phoneQuantity > 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quantity : ${Constants.phoneQuantity}",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            "Description : ${Constants.phoneDescription}",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            "Price : $totalPhonesPrice",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Visibility buildLaptopsDetails(int totalLaptopsPrice) {
    return Visibility(
      visible: (Constants.laptopQuantity > 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quantity : ${Constants.laptopQuantity}",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            "Description : ${Constants.laptopDescription}",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            "Price : $totalLaptopsPrice",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  InkWell buildPayButton(sqlDataBase database, String date, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Constants.laptopQuantity > 0 || Constants.phoneQuantity > 0) {
          database.insertSalesTransaction(
              Constants.invoiceId,
              date,
              Constants.totalAmount,
              Constants.laptopQuantity + Constants.phoneQuantity
          ).then((_) async {
            // Insert data into salesTransactionsInDetails
            if (Constants.laptopQuantity > 0) {
              await database.insertSalesTransactionsInDetails(
                  Constants.invoiceId,
                  Constants.laptopItemId,
                  Constants.laptopDescription,
                  Constants.laptopQuantity,
                  Constants.laptopPrice * Constants.laptopQuantity
              );
            }

            if (Constants.phoneQuantity > 0) {
              await database.insertSalesTransactionsInDetails(
                  Constants.invoiceId,
                  Constants.phoneItemId,
                  Constants.phoneDescription,
                  Constants.phoneQuantity,
                  Constants.phonePrice * Constants.phoneQuantity
              );
            }

            // Reset Constants after successful insertion
            Constants.phoneQuantity = 0;
            Constants.laptopQuantity = 0;
            Constants.totalAmount = 0;

            // Fetch the new invoice id after a successful insert
            await fetchLatestInvoiceId();

            Navigator.pop(context);
          }).catchError((error) {
            // Handle insertion error if needed
            print('Error inserting sales transaction: $error');
          });
        }
      },
      child: buildPayContainer(),
    );
  }
  Container buildPayContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            "Pay",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    fetchLatestInvoiceId();
  }

  Future<void> fetchLatestInvoiceId() async {
    sqlDataBase database = Provider.of<sqlDataBase>(context, listen: false);
    int latestInvoiceId = await database.getLatestInvoiceId();
    setState(() {
      Constants.invoiceId = latestInvoiceId;
    });
  }

}