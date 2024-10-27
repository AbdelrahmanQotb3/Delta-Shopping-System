import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlDataBase extends ChangeNotifier{
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await InitialDB();
      notifyListeners();
    }
    notifyListeners();
    return _db;

  }

  Future<Database> InitialDB() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'information.db');
    Database myDB = await openDatabase(path, onCreate: onCreate, version: 1, onUpgrade: onUpgrade);
    notifyListeners();
    return myDB;
  }

  void onUpgrade(Database db, int oldVersion, int newVersion)  {
    print("Database's been updated successfully ....");
    notifyListeners();
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "items"(
        "itemId" INTEGER NOT NULL PRIMARY KEY,
        "itemDescription" TEXT NOT NULL,
        "itemPrice" INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE "salesTransaction"(
        "invoiceNumber" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "invoiceDate" TEXT NOT NULL,
        "totalPrice" INTEGER NOT NULL,
        "quantity" INTEGER NOT NULL,
        itemId INTEGER ,
        FOREIGN KEY (itemId) REFERENCES items("itemId")
      )
    ''');

    await db.execute('''
      CREATE TABLE "salesTransactionsInDetails"(
        "invoiceNumber" INTEGER NOT NULL,
        "itemId" INTEGER , 
        "itemDescription" TEXT NOT NULL,
        "quantity" INTEGER NOT NULL,
        "totalPrice" INTEGER NOT NULL,
        FOREIGN KEY (itemId) REFERENCES items("itemId"),
        FOREIGN KEY (invoiceNumber) REFERENCES salesTransaction("invoiceNumber")
      )
    ''');


    print("Database's been created successfully ....");
    notifyListeners();
  }

  Future<List<Map>> readData(String sql) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.rawQuery(sql);
    notifyListeners();
    return response;
  }

  // Future<int> insertSalesTransaction(String invoiceDate, int totalPrice, int quantity) async {
  //   Database? myDB = await db;
  //   int response = await myDB!.insert('salesTransaction', {
  //     // 'invoiceNumber': invoiceNumber,
  //     'invoiceDate': invoiceDate,
  //     'totalPrice': totalPrice,
  //     'quantity': quantity,
  //   });
  //   notifyListeners();
  //   return response;
  // }
  Future<void> insertSalesTransaction(int invoiceNumber, String invoiceDate, int totalPrice, int quantity) async {
    Database? myDB = await db;
    var result = await myDB!.rawQuery('SELECT 1 FROM salesTransaction WHERE invoiceNumber = ?', [invoiceNumber]);
    if (result.isEmpty) {
      await myDB.rawInsert(
          'INSERT INTO salesTransaction (invoiceNumber, invoiceDate, totalPrice, quantity) VALUES (?, ?, ?, ?)',
          [invoiceNumber, invoiceDate, totalPrice, quantity]
      );
      print("Data inserted into salesTransaction");
      notifyListeners();
    } else {
      print('Invoice number $invoiceNumber already exists.');
    }
  }


  Future<void> insertSalesTransactionsInDetails(
      int invoiceNumber, int itemId, String itemDescription, int quantity, int totalPrice) async {
    Database? myDB = await db;

    // Check if the record already exists
    var result = await myDB!.rawQuery(
        'SELECT 1 FROM salesTransactionsInDetails WHERE invoiceNumber = ? AND itemId = ?',
        [invoiceNumber, itemId]);

    if (result.isEmpty) {
      // Insert the new record
      await myDB.rawInsert(
          'INSERT INTO salesTransactionsInDetails (invoiceNumber, itemId, itemDescription, quantity, totalPrice) VALUES (?, ?, ?, ?, ?)',
          [invoiceNumber, itemId, itemDescription,quantity, totalPrice]);
      print('Data inserted into salesTransactionsInDetails.');
    } else {
      // Handle the case where the record already exists
      print('Record with invoiceNumber $invoiceNumber and itemId $itemId already exists.');
    }

    notifyListeners();
  }


  Future<int> insertItem( int itemId ,String itemDescription, int itemPrice) async {
    Database? myDB = await db;
    int response = await myDB!.insert('items', {
      'itemId' : itemId,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
    });
    notifyListeners();
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawUpdate(sql);
    notifyListeners();
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawDelete(sql);
    notifyListeners();
    return response;
  }

  Future<int> getLatestInvoiceId() async {
    Database? myDB = await db;
    List<Map<String, dynamic>> result = await myDB!.rawQuery(
        'SELECT MAX(invoiceNumber) as invoiceNumber FROM salesTransaction'
    );
    notifyListeners();
    return result.isNotEmpty ? (result.first['invoiceNumber'] ?? 0) + 1 : 1;
  }

  Future<int> getItemId(String itemName) async {
    Database? myDB = await db;
    List<Map<String, dynamic>> result = await myDB!.rawQuery(
        'SELECT id FROM items WHERE name = ?', [itemName]
    );

    if (result.isNotEmpty) {
      return result.first['id'];
    } else {
      throw Exception('No item found for the given item name');
    }
  }

  Future<void> dropAllTables() async {
    Database? myDB = await db;
    if (myDB != null) {
      await myDB.execute('''
      DROP TABLE IF EXISTS salesTransactionsInDetails;
      DROP TABLE IF EXISTS salesTransaction;
      DROP TABLE IF EXISTS items;
    ''');
      print("All tables have been dropped.");
      notifyListeners();
    }
  }
}
