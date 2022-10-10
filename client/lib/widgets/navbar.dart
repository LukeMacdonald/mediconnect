import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/imports.dart';

class AppBarItem extends StatefulWidget {
  const AppBarItem( {
    Key? key,
    required this.icon,
    required this.index,
  }) : super(key: key);
  final IconData icon;
  final int index;


  @override
  State<AppBarItem> createState() => _AppBarItem();
}
class _AppBarItem extends State<AppBarItem> {
  String role = "";

  Future setRole() async {
    await UserSecureStorage.getRole().then((value) => role = value!);
  }
  @override
  void initState(){
    setRole();
    super.initState();
  }

  Widget getHomePage(String role){
    if (role == "patient"){
      return const HomePage();
    }
    else if(role == "doctor"){
      return const DoctorHomePage();
    }
    else if(role == "superuser"){
      return const AdminHomePage();
    }
    else {
      return const Landing();
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: getHomePage(role)));
          },
        child: SizedBox(
            height: 70,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    widget.icon,
                    size:20,
                    color: widget.index==0 ?AppColors.secondary : null,
                  )])
        )
    );
  }

}

class PatientBottomNavigationBar extends StatefulWidget {
  const PatientBottomNavigationBar({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);


  final int pageIndex ;

  @override
  State<PatientBottomNavigationBar> createState() => _PatientBottomNavigationBar();
}

class _PatientBottomNavigationBar extends State<PatientBottomNavigationBar> {


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
                page:const ChatMenuPatient(),
              ),
              NavigationBarItem(
                index:2,
                label: "prescriptions",
                icon: Icons.medication,
                isSelected: (widget.pageIndex==2),
                page:const HomePage(),
              ),
              NavigationBarItem(
                  label: "appointments",
                  icon: CupertinoIcons.calendar,
                  index: 3,
                  isSelected: (widget.pageIndex==3),
                  page:const UpcomingAppointment(role: "patient",),
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
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const AppBarItem(
        icon: CupertinoIcons.home,
        index: 0,
      ),
      title: const Text("Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      actions: const <Widget>[
        AppBarItem(
          icon: CupertinoIcons.bell_fill,
          index: 5,
        ),
        SizedBox(width: 20),
        AppBarItem(
          icon: CupertinoIcons.settings_solid,
          index: 5,
        ),
        SizedBox(width: 20),

      ],
    );
  }
}

class DoctorBottomNavigationBar extends StatefulWidget {
  const DoctorBottomNavigationBar({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);


  final int pageIndex ;

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
                page:const ChatMenuDoctor(),
              ),
              NavigationBarItem(
                index:2,
                label: "patients",
                icon: CupertinoIcons.person_2,
                isSelected: (widget.pageIndex==2),
                page:const PatientsMenu(),
              ),
              NavigationBarItem(
                label: "appointments",
                icon: CupertinoIcons.calendar,
                index: 3,
                isSelected: (widget.pageIndex==8),
                page:const UpcomingAppointment(role: "doctor"),
              ),
            ],
          ),
        )
    );

  }
}
class AppDropDown extends StatefulWidget {
  const AppDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDropDown> createState() => _AppDropDown();
}
class _AppDropDown extends State<AppDropDown>{
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),

      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
        itemBuilder: (context){
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                  children:const [
                    Padding(
                      padding: EdgeInsets.only(right:10.0),
                      child: Icon(CupertinoIcons.person),
                    ),
                    Text("My Account"),
                  ]
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                  children:const [
                    Padding(
                      padding: EdgeInsets.only(right:10.0),
                      child: Icon(CupertinoIcons.settings_solid),
                    ),
                    Text("Settings"),
                  ]
              ),
            ),

            PopupMenuItem<int>(
              value: 2,
              child: Row(
                  children:const [
                    Padding(
                      padding: EdgeInsets.only(right:10.0),
                      child: Icon(Icons.logout),
                    ),
                    Text("Logout"),
                  ]
              ),
            ),
          ];
        },
        onSelected:(value) async {
          if(value == 0){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ViewProfile()));

          }else if(value == 1){

          }else if(value == 2){
            await UserSecureStorage.logOut();
            if(!mounted)return;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const LogIn()));
          }
        }
    );
  }
}


class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const AppBarItem(
        icon: CupertinoIcons.home,
        index: 0,
      ),
      title: const Text("Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      actions: const <Widget>[
        AppBarItem(
          icon: CupertinoIcons.plus,
          index: 5,
        ),
        AppBarItem(
          icon: CupertinoIcons.bell_fill,
          index: 5,
        ),
        SizedBox(width: 20),
        AppBarItem(
          icon: CupertinoIcons.settings_solid,
          index: 5,
        ),
        SizedBox(width: 20),

      ],
    );
  }
}
