// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bloc_example/blocs/add_post/add_post_bloc.dart' as _i382;
import 'package:bloc_example/blocs/edit_post/edit_post_bloc.dart' as _i188;
import 'package:bloc_example/blocs/post_detail/post_detail_bloc.dart' as _i388;
import 'package:bloc_example/blocs/post_list/post_list_bloc.dart' as _i155;
import 'package:bloc_example/data/post_repository.dart' as _i255;
import 'package:bloc_example/database/app_database.dart' as _i15;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i15.AppDatabase>(() => _i15.AppDatabase());
    gh.lazySingleton<_i255.PostRepository>(
        () => _i255.DriftPostRepository(gh<_i15.AppDatabase>()));
    gh.factory<_i382.AddPostBloc>(
        () => _i382.AddPostBloc(gh<_i255.PostRepository>()));
    gh.factory<_i388.PostDetailBloc>(
        () => _i388.PostDetailBloc(gh<_i255.PostRepository>()));
    gh.factory<_i155.PostListBloc>(
        () => _i155.PostListBloc(gh<_i255.PostRepository>()));
    gh.factory<_i188.EditPostBloc>(
        () => _i188.EditPostBloc(postRepository: gh<_i255.PostRepository>()));
    return this;
  }
}
