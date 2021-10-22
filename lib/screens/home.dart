import 'package:dro/screens/pharmarcy_screen.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 2;
  late List<Widget> lists = [
    placeHolderContent("Home"),
    placeHolderContent("Doctors"),
    const PharmacyScreen(),
    placeHolderContent("Community"),
    placeHolderContent("Profile"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lists[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
            color: txtPurple,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible),
        selectedItemColor: txtPurple,
        unselectedLabelStyle: TextStyle(
            color: mercuryGrey,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            overflow: TextOverflow.visible),
        unselectedItemColor: clayBlack,
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        onTap: (int index) {
          setState(() => _selectedTab = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Doctors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }

  Widget placeHolderContent(String label) {
    return SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: Center(child: Styles.regular(label, fontSize: 16.sp)));
  }
}
