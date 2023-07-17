import 'package:bug_tracker/home/model/user_model.dart';

import 'home/model/deploy_model.dart';
import 'home/model/error_model.dart';
import 'home/model/test_model.dart';

List<ErrorModel> errors = [
  ErrorModel(
    error_id: 'jsdfjdsfjdksfjd',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
  ErrorModel(
    error_id: 'dkfcmefvfkvnfkvnf',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
  ErrorModel(
    error_id: 'dskfdksjdskcisd',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
  ErrorModel(
    error_id: 'fdskfdfrwf0rifrf',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
  ErrorModel(
    error_id: 'kkkkkmcdmsd2w2-ew',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
  ErrorModel(
    error_id: 'o23ejikdmkfndskfnkdsff',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),ErrorModel(
    error_id: 'o23ejikdmkfndskfnkdsff',
    error_msg: 'error_msg',
    error_desc: 'error_desc',
    error_date: DateTime.now(),
    error_priority: 0,
    error_status: 1,
    error_assign: 'hdjfghdfhdhjfhjdf',
    error_reporter: 'fdskfdsjfkjdsf',
  ),
];

List<TestModel> test = [
  
];

List<DeployModel> deploys = [
  DeployModel(deploy_date: DateTime.now(), error_id: 'fdskfdfrwf0rifrf')
];

UserModel userModel = UserModel(
    name: "Mohsen Ghalem",
    email: "ghalemmohsen@gmail.com",
    role: "Flutter Developer",
    imgPath: '',
    isReporter: true);
