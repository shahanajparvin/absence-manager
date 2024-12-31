import 'dart:convert';
import 'package:api/api.dart';
import 'package:flutter/services.dart';


const absencesPath = 'packages/api/assets/json_files/absences.json';
const membersPath = 'packages/api/assets/json_files/members.json';



class ApiImpl implements Api {
  @override
  Future<List<dynamic>?> absences() async {
    return await readJsonFile(absencesPath);
  }

  @override
  Future<List<dynamic>?> members() async {
    return await readJsonFile(membersPath);
  }

  Future<List<dynamic>?> readJsonFile(String path) async {
    try {
      final String content = await rootBundle.loadString(path);
      final Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;
      return data['payload'] as List<dynamic>;
    } catch (error) {
      return null;
    }
  }
}