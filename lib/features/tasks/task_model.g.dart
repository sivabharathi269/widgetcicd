// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Task> _$taskSerializer = _$TaskSerializer();

class _$TaskSerializer implements StructuredSerializer<Task> {
  @override
  final Iterable<Type> types = const [Task, _$Task];
  @override
  final String wireName = 'Task';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Task object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'isCompleted',
      serializers.serialize(
        object.isCompleted,
        specifiedType: const FullType(bool),
      ),
    ];

    return result;
  }

  @override
  Task deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'isCompleted':
          result.isCompleted =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Task extends Task {
  @override
  final String id;
  @override
  final String title;
  @override
  final bool isCompleted;

  factory _$Task([void Function(TaskBuilder)? updates]) =>
      (TaskBuilder()..update(updates))._build();

  _$Task._({required this.id, required this.title, required this.isCompleted})
    : super._();
  @override
  Task rebuild(void Function(TaskBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskBuilder toBuilder() => TaskBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
        id == other.id &&
        title == other.title &&
        isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Task')
          ..add('id', id)
          ..add('title', title)
          ..add('isCompleted', isCompleted))
        .toString();
  }
}

class TaskBuilder implements Builder<Task, TaskBuilder> {
  _$Task? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  TaskBuilder();

  TaskBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _isCompleted = $v.isCompleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Task other) {
    _$v = other as _$Task;
  }

  @override
  void update(void Function(TaskBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Task build() => _build();

  _$Task _build() {
    final _$result =
        _$v ??
        _$Task._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Task', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(title, r'Task', 'title'),
          isCompleted: BuiltValueNullFieldError.checkNotNull(
            isCompleted,
            r'Task',
            'isCompleted',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
