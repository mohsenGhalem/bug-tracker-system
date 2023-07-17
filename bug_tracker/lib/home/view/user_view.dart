import 'package:flutter/material.dart';

import '../../services/shared_prefs.dart';
import '../model/user_model.dart';

class UserView extends StatefulWidget {
  const UserView({
    Key? key,
  }) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserModel? user;
  getCurrentUser() async {
    user = await SharedPrefs.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    getCurrentUser();
    user ??= UserModel(
        name: 'Mohsen Ghalem',
        email: 'email@email.com',
        role: 'Developer',
        imgPath: 'imgPath',
        isReporter: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: size.width * 0.8,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        'Security Information :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    buildContainer(size, 'Email : ${user!.email}'),
                    buildContainer(size, 'Password : ************'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        'Personal Information :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Image.network(
                                user!.imgPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildContainer(size, 'Name : ${user!.name}'),
                    buildContainer(size, 'Role : ${user!.role}'),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 45,
              width: 200,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await SharedPrefs.signOut();
                  },
                  label: const Icon(Icons.logout),
                  icon: const Text('signout')),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Container buildContainer(Size size, String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.all(8),
      height: 50,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
