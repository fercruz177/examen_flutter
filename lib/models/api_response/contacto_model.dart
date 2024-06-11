import 'package:json_annotation/json_annotation.dart';
part 'contacto_model.g.dart';

@JsonSerializable()
class ContactoModel{

  String id;
  String nombre_vendedor;
  String telefono;
  String email;

  ContactoModel(this.id, this.nombre_vendedor, this.telefono, this.email);

  factory ContactoModel.fromJson(Map<String, dynamic> json) => _$ContactoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactoModelToJson(this);


}