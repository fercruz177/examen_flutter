// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactoModel _$ContactoModelFromJson(Map<String, dynamic> json) =>
    ContactoModel(
      json['id'] as String,
      json['nombre_vendedor'] as String,
      json['telefono'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$ContactoModelToJson(ContactoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre_vendedor': instance.nombre_vendedor,
      'telefono': instance.telefono,
      'email': instance.email,
    };
