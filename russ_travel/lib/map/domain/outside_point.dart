import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';

/// Класс для открытых видов

/// Модель точки на карте
class OutsidePoint extends Equatable {
  const OutsidePoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  /// Название населенного пункта
  final String name;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  @override
  List<Object?> get props => [name, latitude, longitude];

  /// Создание объекта OutsidePoint из JSON данных
  factory OutsidePoint.fromJson(Map<String, dynamic> json) {
    return OutsidePoint(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

//   /// Считывание списка точек из файла
//   static Future<List<OutsidePoint>> readPointsFromFile(String filePath) async {
//     final file = File(filePath);
//     try {
//       final jsonString = await file.readAsString();
//       final List<dynamic> pointsData = json.decode(jsonString);
//       return pointsData.map((data) => OutsidePoint.fromJson(data)).toList();
//     } catch (e) {
//       throw Exception('Файл не считывается: $e');
//     }
//   }
 }