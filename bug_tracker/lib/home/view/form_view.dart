import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/fetch_data.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/input_field2.dart';
import '../../widgets/snack_bar.dart';
import '../model/deploy_model.dart';
import '../model/error_model.dart';
import '../model/test_model.dart';
import '../model/user_model.dart';

enum FormType { test, deploy, error }

// ignore: must_be_immutable
class MyForm extends StatelessWidget {
  final FormType formType;
  final _formKey = GlobalKey<FormState>();
  final errorPriority = ['LOW', 'MEDIUM', 'HIGH'];
  final String token;
  final String uid;
  MyForm(
      {required this.token,
      required this.uid,
      required this.formType,
      super.key});

  String nameField = '';
  String assignTo = '';
  String decsField = '';
  String selectedErrorPriority = 'LOW';
  String selectedErrorid = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FetchData fetchData = FetchData(token: token);
    String name = formType == FormType.error
        ? 'Error'
        : formType == FormType.test
            ? 'Test'
            : 'Deploy';
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.7,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        shape: BoxShape.rectangle,
      ),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Create $name',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                InputField2(
                  title: '$name Name',
                  hint: 'write here...',
                  onchange: (value) {
                    nameField = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field required';
                    }
                    return null;
                  },
                ),
                if (formType == FormType.error)
                  InputField2(
                    title: '$name Description',
                    hint: 'write here...',
                    onchange: (value) {
                      decsField = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }
                      return null;
                    },
                  ),
                if (formType == FormType.error)
                  DropDownMenu(
                    hint: 'choose',
                    title: 'Error Priority',
                    items: errorPriority,
                    onChanged: (value) {
                      if (value != null) {
                        selectedErrorPriority = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }
                      return null;
                    },
                  ),
                if (formType == FormType.error)
                  FutureBuilder(
                    future: fetchData.getUsers(''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      final List<UserModel> users = snapshot.data ?? [];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropDownTextField(
                          textFieldDecoration: InputDecoration(
                            hintText: 'Select Item',
                            labelText: 'Assign to',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Colors.indigo, width: 3),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          enableSearch: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field required';
                            }
                            return null;
                          },
                          searchShowCursor: true,
                          onChanged: (value) {
                            assignTo = value.value ?? '';
                          },
                          dropDownList: users
                              .map(
                                (item) => DropDownValueModel(
                                    name: '${item.name} - ${item.email}',
                                    value: item.uid),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                if (formType != FormType.error)
                  FutureBuilder(
                    future: fetchData.getErrors(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      final List<ErrorModel> errors = snapshot.data ?? [];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropDownTextField(
                          textFieldDecoration: InputDecoration(
                            hintText: 'Select Item',
                            suffix: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                            labelText: 'Choose Error',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Colors.indigo, width: 3),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          enableSearch: true,
                          searchShowCursor: true,
                          onChanged: (value) {
                            print(value.value);
                            selectedErrorid = value.value ?? '';
                          },
                          dropDownList: errors
                              .map(
                                (item) => DropDownValueModel(
                                  name: item.error_msg,
                                  value: item.error_id,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async => validate(),
                  child: Text('Create $name'),
                )
              ],
            ),
          )),
    );
  }

  void validate() async {
    if (_formKey.currentState!.validate()) {
      final FetchData fetchData = FetchData(token: token);
      if (formType == FormType.error) {
        ErrorModel errorModel = ErrorModel(
          error_msg: nameField,
          error_desc: decsField,
          error_date: DateTime.now(),
          error_priority: !errorPriority.contains(selectedErrorPriority)
              ? 0
              : errorPriority.indexOf(selectedErrorPriority),
          error_status: 0,
          error_assign: assignTo,
          error_reporter: uid,
        );

       

        loadingDialog(future: fetchData.createError(errorModel));
      } else if (formType == FormType.test) {
        TestModel testModel = TestModel(
            error_id: selectedErrorid, uid: uid, tests: [], test_status: false);
        await loadingDialog(future: fetchData.createTest(testModel));
      } else {
        DeployModel deployModel =
            DeployModel(deploy_date: DateTime.now(), error_id: selectedErrorid);
        await loadingDialog(future: fetchData.createDeploy(deployModel));
      }
    }
  }

  loadingDialog({Future<void>? future}) async {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  Get.back(result: snapshot.error);
                } else {
                  Get.back();
                }
              }
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    Text('Loading')
                  ],
                ),
              );
            }),
      ),
    ).then(
      (value) {
        if (value == null) {
          Get.back();
          Get.showSnackbar(buildSnackBar('item added', Colors.green));
        } else {
          Get.back();
          Get.showSnackbar(buildSnackBar('error occured', Colors.red));
        }
      },
    );
  }
}
