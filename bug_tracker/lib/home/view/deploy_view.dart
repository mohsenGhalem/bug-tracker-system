import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/fetch_data.dart';
import '../../services/shared_prefs.dart';
import '../../widgets/header_bar.dart';
import '../model/deploy_model.dart';
import 'form_view.dart';

class DeployView extends StatefulWidget {
  const DeployView({super.key});

  @override
  State<DeployView> createState() => _DeployViewState();
}

class _DeployViewState extends State<DeployView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          HeaderBar(
            btnTitle: 'Create Deploy',
            onPressed: () async {
              final user = await SharedPrefs.currentUser;
              return Get.dialog(
                Dialog(
                  child: MyForm(
                    formType: FormType.deploy,
                    token: await SharedPrefs.token,
                    uid: user.uid ?? '',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getErrors(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final List<DeployModel> items = snapshot.data;
                    if (items.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sledding_rounded, size: 40),
                            Text('no deploys found !')
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
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          title:
                              Text('Deploy date: ${items[index].deploy_date}'),
                          subtitle: Text(
                            'Error id: ${items[index].error_id}',
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

  Future<List<DeployModel>> getErrors() async {
    final FetchData fetchData = FetchData(token: await SharedPrefs.token);

    return fetchData.getDeploys();
  }
}
