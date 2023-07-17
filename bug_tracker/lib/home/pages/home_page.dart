import 'package:bug_tracker/services/shared_prefs.dart';

import '../model/user_model.dart';
import '../view/deploy_view.dart';
import '../view/error_view.dart';
import '../view/test_view.dart';
import '../view/user_view.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  late UserModel user = UserModel(
      name: 'name',
      email: 'email',
      role: 'role',
      imgPath: 'imgPath',
      isReporter: true);
  final pages = const [ErrorView(), TestView(), DeployView(), UserView()];
  getCurrentUser() async {
    user = await SharedPrefs.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    

    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    sideMenu.removeListener(
      (index) {
        pageController.jumpToPage(0);
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> items = [
      SideMenuItem(
        priority: 0,
        title: 'Errors',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.error),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Tests',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.science_outlined),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Deploys',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.checklist_outlined),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Account',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.person),
      ),
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Bug Tracker system',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              style: SideMenuStyle(
                backgroundColor: Colors.blueGrey,
                selectedColor: Colors.amber,
                unselectedIconColor: Colors.white,
                unselectedTitleTextStyle: const TextStyle(color: Colors.white),
              ),
              controller: sideMenu,
              showToggle: true,
              onDisplayModeChanged: (mode) {
                print(mode);
              },
              items: items,
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
