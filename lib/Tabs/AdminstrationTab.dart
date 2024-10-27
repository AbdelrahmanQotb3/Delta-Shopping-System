import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Database/sqlDB.dart';

class AdminstrationTab extends StatefulWidget {

  const AdminstrationTab({super.key});

  @override
  State<AdminstrationTab> createState() => _AdminstrationTabState();
}

class _AdminstrationTabState extends State<AdminstrationTab> {
  @override
  Widget build(BuildContext context) {
    sqlDataBase database = Provider.of<sqlDataBase>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // show all items button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    List<Map> response = await database.readData("SELECT * FROM 'items'");
                    print("$response");
                  },
                  child: Text("Show all items"),
                ),
              ),
              // show all transaction button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    List<Map> response = await database.readData("SELECT * FROM 'salesTransaction'");
                    print("$response");
                  },
                  child: Text("Show all transactions"),
                ),
              ),
              // show all transactions in detail
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    List<Map> response = await database.readData("SELECT * FROM 'salesTransactionsInDetails'");
                    print("$response");
                  },
                  child: Text("Show all transactions details"),
                ),
              ),
              // clear all transactions button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await database.deleteData("DELETE FROM 'salesTransaction'");
                    print("$response");
                  },
                  child: Text("Clear all transactions"),
                ),
              ),
              // clear all transactions details button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await database.deleteData("DELETE FROM 'salesTransactionsInDetails'");
                    print("$response");
                  },
                  child: Text("Clear all transactions details"),
                ),
              ),
              // clear all items button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await database.deleteData("DELETE FROM 'items'");
                    print("$response");
                  },
                  child: Text("Clear all items"),
                ),
              ),
              // insert laptop to items button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await database.insertItem(Constants.laptopItemId , "HPLaptop,15GW-Ryzen3,3250U,2-Cores,8GB-RAM,1TB-HDD", Constants.laptopPrice);
                    print("$response");
                  },
                  child: Text("insert laptop to items"),
                ),
              ),
              // insert phone to items button
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await database.insertItem(Constants.phoneItemId,"AppleIPhone15-(128GB),6GB-RAM", Constants.phonePrice);
                    print("$response");
                  },
                  child: Text("insert phone to items"),
                ),
              ),
              // drop all
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    await database.dropAllTables();
                    print("Database has been deleted successfully ");
                  },
                  child: Text("Drop all Database"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}