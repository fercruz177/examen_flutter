// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anuncio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnuncioModel _$AnuncioModelFromJson(Map<String, dynamic> json) => AnuncioModel(
      json['id'] as String,
      json['titulo'] as String,
      json['tipo'] as String,
      (json['precio'] as num).toDouble(),
      json['imagen'] as String,
      json['longitud'] as String,
      json['latitud'] as String,
      json['descripcion'] as String,
    );

Map<String, dynamic> _$AnuncioModelToJson(AnuncioModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'tipo': instance.tipo,
      'precio': instance.precio,
      'imagen': instance.imagen,
      'longitud': instance.longitud,
      'latitud': instance.latitud,
      'descripcion': instance.descripcion,
    };
