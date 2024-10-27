import 'package:flutter/material.dart';

class totalAmountContainer extends StatefulWidget {

  totalAmountContainer({super.key});

  @override
  State<totalAmountContainer> createState() => _totalAmountContainerState();
}

class _totalAmountContainerState extends State<totalAmountContainer> {
  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text("Total Amount" , style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          SizedBox(height: 10,),
          Text("$totalAmount" , style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,

          )),
        ],
      ),
    );
  }


}