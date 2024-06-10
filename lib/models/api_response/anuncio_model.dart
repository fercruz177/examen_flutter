import 'package:json_annotation/json_annotation.dart';
part 'anuncio_model.g.dart';

@JsonSerializable()
class AnuncioModel{

  String id;
  String titulo;
  String tipo;
  double precio;
  String imagen;
  String longitud;
  String latitud;
  String descripcion;

  AnuncioModel(this.id, this.titulo, this.tipo, this.precio, this.imagen,
      this.longitud, this.latitud, this.descripcion);

  factory AnuncioModel.fromJson(Map<String, dynamic> json) => _$AnuncioModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnuncioModelToJson(this);


}