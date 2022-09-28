import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/booking/set_availability.dart';
import 'package:nd_telemedicine/pages/chats/chats_page.dart';
import 'package:nd_telemedicine/pages/booking/booking_by_time.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user.dart';
import '../pages/homepage/admin_home.dart';
import '../pages/homepage/doctor_home.dart';
import '../pages/homepage/home_page.dart';
import '../pages/landing.dart';
import '../styles/theme.dart';
//

Widget getHomePage(User user){
  if (user.role == "patient"){
    return HomePage(user: user);
  }
  else if(user.role == "doctor"){
    return DoctorHomePage(user: user);
  }
  else if(user.role == "superuser"){
    return AdminHomePage(user: user);
  }
  else {
    return const Landing();
  }

}

class AppBarItem extends StatelessWidget {
  const AppBarItem( {
    Key? key,
    required this.icon,
    required this.index,
    required this.user,

  }) : super(key: key);
  final IconData icon;
  final int index;
  final User user;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: getHomePage(user)));
          },
        child: SizedBox(
            height: 70,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icon,
                    size:20,
                    color: index==0 ?AppColors.secondary : null,
                  )])
        )
    );
  }

}

class CustomBBottomNavigationBar extends StatefulWidget {
  const CustomBBottomNavigationBar({
    Key? key,
    required this.pageIndex,
    required this.user
  }) : super(key: key);


  final int pageIndex ;
  final User user;

  @override
  State<CustomBBottomNavigationBar> createState() => _CustomBBottomNavigationBar();
}

class _CustomBBottomNavigationBar extends State<CustomBBottomNavigationBar> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top:false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top:16,left:8,right:8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                label: "messaging",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                index: 1,
                isSelected: (widget.pageIndex==1),
                page:ChatsPage(user:widget.user),
              ),
              NavigationBarItem(
                index:2,
                label: "prescriptions",
                icon: Icons.medication,
                isSelected: (widget.pageIndex==3),
                page:HomePage(user:widget.user),
              ),
              NavigationBarItem(
                  label: "appointments",
                  icon: CupertinoIcons.calendar,
                  index: 3,
                  isSelected: (widget.pageIndex==4),
                  page:BookingByTime(user:widget.user),
              )
              //_NavigationBarItem(),
              //_NavigationBarItem(),
            ],
          ),
        )
    );

  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.index,
    this.isSelected = false,
    required this.page

  }) : super(key: key);

  final Widget page;
  final String label;
  final IconData icon;
  final bool isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: page));
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size:20,
              color: isSelected ?AppColors.secondary : null,
            ),
            const SizedBox(
                height: 8),
            Text(
                label,
                style: isSelected ?
                const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color:AppColors.secondary,
                ) : const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: AppBarItem(
        icon: CupertinoIcons.home,
        index: 0, user: user,
      ),
      title: const Text("Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      actions: <Widget>[
        AppBarItem(
          icon: CupertinoIcons.bell_fill,
          index: 5, user: user,
        ),
        const SizedBox(width: 20),
        AppBarItem(
          icon: CupertinoIcons.settings_solid,
          index: 5, user: user,
        ),
        const SizedBox(width: 20),

      ],
    );
  }
}

class DoctorBottomNavigationBar extends StatefulWidget {
  const DoctorBottomNavigationBar({
    Key? key,
    required this.pageIndex,
    required this.user
  }) : super(key: key);


  final int pageIndex ;
  final User user;

  @override
  State<DoctorBottomNavigationBar> createState() => _DoctorBottomNavigationBar();
}

class _DoctorBottomNavigationBar extends State<DoctorBottomNavigationBar> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top:false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top:16,left:8,right:8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                label: "messaging",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                index: 1,
                isSelected: (widget.pageIndex==1),
                page:ChatsPage(user:widget.user),
              ),
              NavigationBarItem(
                index:2,
                label: "patients",
                icon: Icons.medication,
                isSelected: (widget.pageIndex==7),
                page:HomePage(user:widget.user),
              ),
              NavigationBarItem(
                label: "appointments",
                icon: CupertinoIcons.calendar,
                index: 3,
                isSelected: (widget.pageIndex==8),
                page:SetAvailability(user:widget.user),
              )
              //_NavigationBarItem(),
              //_NavigationBarItem(),
            ],
          ),
        )
    );

  }
}