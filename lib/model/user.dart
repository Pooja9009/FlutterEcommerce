// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@JsonSerializable()
@Entity()
class User {
  @Id(assignable: true)
  int userId;
  String? fullName;
  String? email;
  String? dob;
  String? phone;
  String? password;
  String? avatar;

  User(this.fullName, this.email, this.dob, this.phone, this.password,
      this.avatar,
      {this.userId = 0});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
