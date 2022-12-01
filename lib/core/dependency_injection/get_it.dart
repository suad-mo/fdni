import 'package:fdni/feature/firm/data/data_sources/local_data_source/documents_local_data_source_impl.dart';
import 'package:fdni/feature/firm/data/repositories/document_repository_impl.dart';
import 'package:fdni/feature/firm/domain/repositories/document_repository.dart';
import 'package:get_it/get_it.dart';

import '../../feature/firm/data/data_sources/local_data_source/documents_local_data_source.dart';
import '../../feature/firm/domain/use_cases/get_all_firms.dart';
import '../../feature/firm/presentation/blocs/firm_bloc/firm_bloc.dart';

final getIt = GetIt.instance;

class AppGetIt {
  const AppGetIt._();
  static Future init() async {
    // presentation logic holder
    getIt.registerLazySingleton(
        () => FirmBloc(getAllFirmsUseCase: getIt<GetAllFirmsUseCase>()));

    // user case
    getIt.registerLazySingleton(
        () => GetAllFirmsUseCase(repository: getIt<DocumentRepository>()));

    // repository
    getIt.registerLazySingleton<DocumentRepository>(() =>
        DocumentRepositoryImpl(
            localDataSource: getIt<DocumentsLocalDataSource>()));

    //data source
    getIt.registerLazySingleton<DocumentsLocalDataSource>(
        () => DocumentsLocalDataSourceImpl());

    // external
  }
}
