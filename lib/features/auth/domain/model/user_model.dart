import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
@JsonSerializable()
class UserModel extends Equatable{
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String? phoneNo;

  const UserModel({required this.id, required this.name, required this.email, required this.photoUrl, this.phoneNo = ''});

  factory UserModel.fromJson(Map<String,dynamic> json) => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [id, name, email, photoUrl, phoneNo];
}