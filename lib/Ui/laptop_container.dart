import 'package:flutter/material.dart';

class laptopContainer extends StatelessWidget {
  final VoidCallback onClick;
  int laptopPrice ;
  laptopContainer({super.key, required this.onClick , required this .laptopPrice});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white38,
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text("HP Laptop",
                  style: TextStyle(
                      color: Color(0xff344054),
                      fontSize: 22,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text(
                  "HP 15-GW",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text(
                  "Laptop-Ryzen 3",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text(
                  " 3250U 2-Cores,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text(
                  "8 GB RAM,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text(
                  "1 TB HDD",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text("\$$laptopPrice USD",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              InkWell(
                onTap: onClick,
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            "Assets/hpLaptop.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}