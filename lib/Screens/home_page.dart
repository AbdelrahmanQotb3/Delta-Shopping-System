import 'package:final_project/Constants/Constants.dart';
import 'package:flutter/material.dart';

import '../Tabs/AdminstrationTab.dart';
import '../Tabs/HomeTab.dart';

class HomePage extends StatefulWidget {
  static String routeName = "HomePage";
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;
  Widget Body = HomeTab();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: InkWell(
        onTap: (){},
        child: Image(
          image: AssetImage(Constants.appBarIcon),
        ) ,
      ),
      title: Text(
        "Shopping",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange
        ),
      ),
      centerTitle: true,
      actions: [
        InkWell(onTap: (){},child: Icon(Icons.more_vert , color: Colors.deepOrange,))
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex:currentTabIndex,
      onTap: (index){
        currentTabIndex = index;
        if(index == 0 ){
          Body = HomeTab();
        }
        else if(index == 1){
          Body = AdminstrationTab();
        }
        setState(() {

        });
      },
      backgroundColor: Colors.deepOrangeAccent,
      elevation: 0,
      selectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(Constants.homeNavigationIcon)),label: Constants.homeNavigationLabel),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(Constants.administrationNavigationIcon)),label: Constants.administrationNavigationLabel),
      ],

    );
  }
}