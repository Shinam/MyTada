import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tada_beta/app/core/models/pp_user.dart';
import 'package:tada_beta/app/core/models/prizepool.dart';

import '../app/core/models/task.dart';
import '../app/core/models/task_details.dart';

class ApiService {
  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      String jsonData2 =
          await rootBundle.loadString('lib/ui/assets/json/tasks.json');
      // Convertir le JSON en une liste d'objets Task
      List<Task> tasks = [];
      Map<String, dynamic> jsonMap = json.decode(jsonData2);

      List<dynamic> taskList = jsonMap['tasks'];
      taskList.forEach((taskData) {
        Task task = Task.fromJson(taskData);
        tasks.add(task);
      });

      return tasks;
    } catch (e) {
      print('Erreur lors de la lecture du fichier JSON : $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<List<PpUser>> getPpUser() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      List<PpUser> pps = [];
      String jsonData2 =
          await rootBundle.loadString('lib/ui/assets/json/pp_user.json');
      Map<String, dynamic> jsonMap = json.decode(jsonData2);
      List<dynamic> ppList = jsonMap['prizepool_1_shinam'];
      ppList.forEach((ppData) {
        PpUser ppUser = PpUser.fromJson(ppData);
        pps.add(ppUser);
      });
      return pps;
    } catch (e) {
      print('Erreur lors de la lecture du fichier JSON : $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<List<Prizepool>> getPrizePools() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      String jsonData2 =
          await rootBundle.loadString('lib/ui/assets/json/prizepools.json');
      // Convertir le JSON en une liste d'objets Task
      List<Prizepool> prizepools = [];
      Map<String, dynamic> jsonMap = json.decode(jsonData2);

      List<dynamic> ppList = jsonMap['prizepools'];
      ppList.forEach((ppData) {
        Prizepool prizepool = Prizepool.fromJson(ppData);
        prizepools.add(prizepool);
      });

      return prizepools;
    } catch (e) {
      print('Erreur lors de la lecture du fichier JSON : $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<TaskDetails> getTaskDetails(int id) async {
    try {
      String jsonData2 =
          await rootBundle.loadString('lib/ui/assets/json/task_details.json');
      Map<String, dynamic> jsonMap = json.decode(jsonData2);
      List<dynamic> taskList = jsonMap['task_details'];

      // Utiliser firstWhere pour trouver la tâche avec l'id correspondant
      TaskDetails taskDetails = taskList
          .map((taskData) => TaskDetails.fromJson(taskData))
          .firstWhere((task) => task.idTask == id,
              orElse: () => TaskDetails(
                  id: 0,
                  idTask: id,
                  type: 'Unknown',
                  category: 'Unknown',
                  sex: 'Unknown',
                  noise: false,
                  sentence: 'Unknown',
                  sexConsensus: 0,
                  noiseConsensus: 0,
                  sentenceConsensus: 0,
                  verifierResults: []));

      return taskDetails;
    } catch (e) {
      print('Erreur lors de la lecture du fichier JSON : $e');
      return TaskDetails(
        id: 0,
        idTask: id,
        type: 'Error',
        category: 'Error',
        sex: 'Error',
        noise: false,
        sentence: 'Error',
        sexConsensus: 0,
        noiseConsensus: 0,
        sentenceConsensus: 0,
        verifierResults: [],
      );
    }
  }
}
