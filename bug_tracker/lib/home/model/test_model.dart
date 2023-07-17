// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TestModel {
  String? test_id;
  String error_id;
  String uid;
  List<dynamic> tests;
  bool test_status;
  TestModel({
    this.test_id,
    required this.error_id,
    required this.uid,
    required this.tests,
    required this.test_status,
  });

  TestModel copyWith({
    String? test_id,
    String? error_id,
    String? uid,
    List<dynamic>? tests,
    bool? test_status,
  }) {
    return TestModel(
      test_id: test_id ?? this.test_id,
      error_id: error_id ?? this.error_id,
      uid: uid ?? this.uid,
      tests: tests ?? this.tests,
      test_status: test_status ?? this.test_status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      
      'error_id': error_id,
      'uid': uid,
      'tests': tests,
      'test_status': test_status,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      test_id: map['_id'] != null ? map['_id'] as String : null,
      error_id: map['error_id'] as String,
      uid: map['uid'] as String,
      tests: List<dynamic>.from((map['tests'] as List<dynamic>)),
      test_status: map['test_status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) =>
      TestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TestModel(_id: $test_id, error_id: $error_id, uid: $uid, tests: $tests, test_status: $test_status)';
  }

  @override
  bool operator ==(covariant TestModel other) {
    if (identical(this, other)) return true;

    return other.test_id == test_id &&
        other.error_id == error_id &&
        other.uid == uid &&
        listEquals(other.tests, tests) &&
        other.test_status == test_status;
  }

  @override
  int get hashCode {
    return test_id.hashCode ^
        error_id.hashCode ^
        uid.hashCode ^
        tests.hashCode ^
        test_status.hashCode;
  }
}
