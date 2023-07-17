import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/fetch_data.dart';
import '../../services/shared_prefs.dart';
import '../../widgets/header_bar.dart';
import '../model/test_model.dart';
import 'form_view.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          HeaderBar(
              btnTitle: 'Create test',
              onPressed: () async {
                final user = await SharedPrefs.currentUser;
                return Get.dialog(Dialog(
                  child: MyForm(
                    formType: FormType.test,
                    token: await SharedPrefs.token,
                    uid: user.uid ?? '',
                  ),
                ));
              }),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getErrors(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final List<TestModel> items = snapshot.data;
                    if (items.isEmpty) {
                      return const Center(
                        child: Column(
                          children: [
                            Icon(Icons.sledding_rounded, size: 40),
                            Text('no test found !')
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          shape: const RoundedRectangleBorder(),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.science,
                              color: Colors.white,
                            ),
                          ),
                          title: Text('Test id = ${items[index].test_id}'),
                          subtitle: Text(
                            items[index].test_status.toString(),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz),
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Column(
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        Text('an error occured !')
                      ],
                    ));
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<TestModel>> getErrors() async {
    final FetchData fetchData = FetchData(token: await SharedPrefs.token);

    return fetchData.getTests();
  }
}
