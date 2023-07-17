// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeployModel {
  String? deploy_id;
  DateTime deploy_date;
  String error_id;
  DeployModel({
    this.deploy_id,
    required this.deploy_date,
    required this.error_id,
  });

  DeployModel copyWith({
    String? deploy_id,
    DateTime? deploy_date,
    String? error_id,
  }) {
    return DeployModel(
      deploy_id: deploy_id ?? this.deploy_id,
      deploy_date: deploy_date ?? this.deploy_date,
      error_id: error_id ?? this.error_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
     
      'deploy_date': deploy_date.toString(),
      'error_id': error_id,
    };
  }

  factory DeployModel.fromMap(Map<String, dynamic> map) {
    return DeployModel(
      deploy_id: map['_id'] != null ? map['_id'] as String : null,
      deploy_date:
          DateTime.parse(map['deploy_date'] as String),
      error_id: map['error_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeployModel.fromJson(String source) =>
      DeployModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DeployModel(_id: $deploy_id, deploy_date: $deploy_date, error_id: $error_id)';

  @override
  bool operator ==(covariant DeployModel other) {
    if (identical(this, other)) return true;

    return other.deploy_id == deploy_id &&
        other.deploy_date == deploy_date &&
        other.error_id == error_id;
  }

  @override
  int get hashCode =>
      deploy_id.hashCode ^ deploy_date.hashCode ^ error_id.hashCode;
}
