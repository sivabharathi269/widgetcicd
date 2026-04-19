import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'task_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  Task
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();