import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/fetch_data.dart';
import '../../services/shared_prefs.dart';
import '../../widgets/header_bar.dart';
import '../model/error_model.dart';
import 'form_view.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({super.key});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          HeaderBar(
              btnTitle: 'Create Error',
              onPressed: () async {
                final user = await SharedPrefs.currentUser;
                return Get.dialog(Dialog(
                  child: MyForm(
                    formType: FormType.error,
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
                    final List<ErrorModel> items = snapshot.data;
                    if (items.isEmpty) {
                      return const Center(
                        child: Column(
                          children: [
                            Icon(Icons.sledding_rounded, size: 40),
                            Text('no errors found !')
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
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(items[index].error_msg),
                          subtitle: Text(
                            items[index].error_date.toString(),
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

  Future<List<ErrorModel>> getErrors() async {
    final FetchData fetchData = FetchData(token: await SharedPrefs.token);

    return fetchData.getErrors();
  }
}
