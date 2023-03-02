// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'model/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6046979236885454050),
      name: 'User',
      lastPropertyId: const IdUid(7, 8149046748300630618),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8139430995462315784),
            name: 'userId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 6006602579925838833),
            name: 'fullName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7268398734381242382),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7449392069996505930),
            name: 'dob',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 513654186452822024),
            name: 'phone',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6882136989287703903),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8149046748300630618),
            name: 'avatar',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 6046979236885454050),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.userId,
        setId: (User object, int id) {
          object.userId = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final fullNameOffset = object.fullName == null
              ? null
              : fbb.writeString(object.fullName!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final dobOffset =
              object.dob == null ? null : fbb.writeString(object.dob!);
          final phoneOffset =
              object.phone == null ? null : fbb.writeString(object.phone!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final avatarOffset =
              object.avatar == null ? null : fbb.writeString(object.avatar!);
          fbb.startTable(8);
          fbb.addInt64(0, object.userId);
          fbb.addOffset(1, fullNameOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, dobOffset);
          fbb.addOffset(4, phoneOffset);
          fbb.addOffset(5, passwordOffset);
          fbb.addOffset(6, avatarOffset);
          fbb.finish(fbb.endTable());
          return object.userId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              userId:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.userId]
  static final userId = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.fullName]
  static final fullName = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[0].properties[2]);

  /// see [User.dob]
  static final dob = QueryStringProperty<User>(_entities[0].properties[3]);

  /// see [User.phone]
  static final phone = QueryStringProperty<User>(_entities[0].properties[4]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[0].properties[5]);

  /// see [User.avatar]
  static final avatar = QueryStringProperty<User>(_entities[0].properties[6]);
}
