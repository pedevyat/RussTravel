import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Класс для музеев

/// Модель точки на карте
class MuseumPoint extends Equatable {
  MuseumPoint({
    required this.id,
    //required this.isVisited,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.photoUrl, // Добавлено новое поле для ссылки на фото
  });
  
  // Идентификационный номер
  int id;
  
  // Посещена ли метка
  //final bool isVisited;

  /// Название населенного пункта
  final String name;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  /// Ссылка на фото
  final String photoUrl; // Добавлено новое поле для ссылки на фото

  @override
  List<Object?> get props => [name, latitude, longitude, photoUrl];

  /// Создание объекта MuseumPoint из JSON данных
  factory MuseumPoint.fromJson(Map<String, dynamic> json) {
    return MuseumPoint(
      id: 0,
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photoUrl: json['photoUrl'], // Получаем ссылку на фото из JSON
    );
  }
}
