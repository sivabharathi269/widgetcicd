import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'task_model.g.dart';

abstract class Task implements Built<Task, TaskBuilder> {


  Task._();

  factory Task([void Function(TaskBuilder) updates]) = _$Task;

  // JSON
  String toJson() {
    return json.encode(serializers.serializeWith(Task.serializer, this));
  }

  static Task? fromJson(String jsonString) {
    return serializers.deserializeWith(
      Task.serializer,
      json.decode(jsonString),
    );
  }

  static Serializer<Task> get serializer => _$taskSerializer;
  String get id;
  String get title;
  bool get isCompleted;
}