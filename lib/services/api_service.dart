// lib/services/api_service.dart

import 'package:dio/dio.dart';

import '../models/experience_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Experience>> fetchExperiences() async {
    const String url = 'https://staging.chamberofsecrets.8club.co/v1/experiences?active=true';
    try {
      final response = await _dio.get(url);
      final data = response.data['data']['experiences'] as List;
      return data.map((e) => Experience.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load experiences');
    }
  }
}
