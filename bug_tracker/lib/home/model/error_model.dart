// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorModel {
  String? error_id;
  String error_msg;
  String error_desc;
  DateTime error_date;
  int error_priority;
  int error_status;
  String error_assign;
  String error_reporter;
  ErrorModel({
    this.error_id,
    required this.error_msg,
    required this.error_desc,
    required this.error_date,
    required this.error_priority,
    required this.error_status,
    required this.error_assign,
    required this.error_reporter,
  });

  ErrorModel copyWith({
    String? error_id,
    String? error_msg,
    String? error_desc,
    DateTime? error_date,
    int? error_priority,
    int? error_status,
    String? error_assign,
    String? error_reporter,
  }) {
    return ErrorModel(
      error_id: error_id ?? this.error_id,
      error_msg: error_msg ?? this.error_msg,
      error_desc: error_desc ?? this.error_desc,
      error_date: error_date ?? this.error_date,
      error_priority: error_priority ?? this.error_priority,
      error_status: error_status ?? this.error_status,
      error_assign: error_assign ?? this.error_assign,
      error_reporter: error_reporter ?? this.error_reporter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "error_msg": error_msg,
      "error_desc": error_desc,
      "error_priority": error_priority,
      "error_status": error_status,
      "error_assign": error_assign,
      "error_reporter": error_reporter
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      error_id: map['_id'] != null ? map['_id'] as String : null,
      error_msg: map['error_msg'] as String,
      error_desc: map['error_desc'] as String,
      error_date: DateTime.parse(map['error_date'] as String),
      error_priority: map['error_priority'] as int,
      error_status: map['error_status'] as int,
      error_assign: map['error_assign'] as String,
      error_reporter: map['error_reporter'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ErrorModel(_id: $error_id, error_msg: $error_msg, error_desc: $error_desc, error_date: $error_date, error_priority: $error_priority, error_status: $error_status, error_assign: $error_assign, error_reporter: $error_reporter)';
  }

  @override
  bool operator ==(covariant ErrorModel other) {
    if (identical(this, other)) return true;

    return other.error_id == error_id &&
        other.error_msg == error_msg &&
        other.error_desc == error_desc &&
        other.error_date == error_date &&
        other.error_priority == error_priority &&
        other.error_status == error_status &&
        other.error_assign == error_assign &&
        other.error_reporter == error_reporter;
  }

  @override
  int get hashCode {
    return error_id.hashCode ^
        error_msg.hashCode ^
        error_desc.hashCode ^
        error_date.hashCode ^
        error_priority.hashCode ^
        error_status.hashCode ^
        error_assign.hashCode ^
        error_reporter.hashCode;
  }
}
