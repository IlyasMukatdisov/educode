import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SectionModel {
  final int id;
  final String name;
  final String description;

  SectionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
  
}
