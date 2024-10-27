import 'package:flutter/material.dart';

class phoneContainer extends StatelessWidget {
  final VoidCallback onClick;
  int iphonePrice ;
  phoneContainer({super.key , required this.onClick , required this.iphonePrice});



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white38
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                Image(image: AssetImage("Assets/iphone15.png") , width: 100,)
              ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Text(
                  "Apple IPhone 15",
                  style: TextStyle(
                      color: Colors.black ,
                      fontSize: 18 ,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Text(
                  "-(128GB), 6GB RAM",
                  style: TextStyle(
                      color: Colors.black ,
                      fontSize: 18 ,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Text("${iphonePrice} USD" , style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),)
                // Text(
                //   "-(128GB), 6GB RAM",
                //   style: TextStyle(
                //       color: Colors.black ,
                //       fontSize: 18 ,
                //       fontWeight: FontWeight.normal
                //   ),
                // ),

              ],
            ),
            InkWell(
              onTap: onClick,
              child: Container (
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text("Add to Cart" , style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),)
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
