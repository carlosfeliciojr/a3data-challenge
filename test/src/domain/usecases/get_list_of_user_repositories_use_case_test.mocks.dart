// Mocks generated by Mockito 5.3.2 from annotations
// in a3data_challenge/test/src/domain/usecases/get_list_of_user_repositories_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:a3data_challenge/src/domain/entities/repository_entity.dart'
    as _i4;
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart'
    as _i5;
import 'package:a3data_challenge/src/domain/services/repository_services.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [RepositoryServices].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepositoryServices extends _i1.Mock
    implements _i2.RepositoryServices {
  @override
  _i3.Future<List<_i4.RepositoryEntity>> getListOfRepositories(
          {required _i5.GetListOfRepositoriesParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getListOfRepositories,
          [],
          {#params: params},
        ),
        returnValue: _i3.Future<List<_i4.RepositoryEntity>>.value(
            <_i4.RepositoryEntity>[]),
        returnValueForMissingStub: _i3.Future<List<_i4.RepositoryEntity>>.value(
            <_i4.RepositoryEntity>[]),
      ) as _i3.Future<List<_i4.RepositoryEntity>>);
  @override
  _i3.Future<List<_i4.RepositoryEntity>> getListOfUserRepositories(
          {required _i5.GetListOfRepositoriesParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getListOfUserRepositories,
          [],
          {#params: params},
        ),
        returnValue: _i3.Future<List<_i4.RepositoryEntity>>.value(
            <_i4.RepositoryEntity>[]),
        returnValueForMissingStub: _i3.Future<List<_i4.RepositoryEntity>>.value(
            <_i4.RepositoryEntity>[]),
      ) as _i3.Future<List<_i4.RepositoryEntity>>);
}
