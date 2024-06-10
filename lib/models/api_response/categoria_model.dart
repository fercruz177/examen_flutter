import 'package:json_annotation/json_annotation.dart';

part 'categoria_model.g.dart';

@JsonSerializable()
class CategoriaModel{
  String id;
  String nombre;

  CategoriaModel(this.id, this.nombre);

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => _$CategoriaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriaModelToJson(this);
}