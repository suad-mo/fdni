import 'package:fdni/feature/firm/data/data_sources/local_data_source/documents_local_data_source_impl.dart';
import 'package:fdni/feature/firm/data/repositories/document_repository_impl.dart';
import 'package:fdni/feature/firm/domain/repositories/document_repository.dart';
import 'package:fdni/feature/firm/domain/use_cases/get_documents_firms_by_id.dart';
import 'package:fdni/feature/firm/domain/use_cases/get_firm_all_documents_by_id.dart';
import 'package:fdni/feature/firm/presentation/blocs/firm_all_documents_bloc/firm_all_documents_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../feature/firm/data/data_sources/local_data_source/documents_local_data_source.dart';
import '../../feature/firm/domain/use_cases/get_all_documents.dart';
import '../../feature/firm/domain/use_cases/get_all_firms.dart';
import '../../feature/firm/domain/use_cases/get_document_by_id.dart';
import '../../feature/firm/presentation/blocs/document_bloc/document_bloc.dart';
import '../../feature/firm/presentation/blocs/document_firm_bloc/document_firm_bloc.dart';
import '../../feature/firm/presentation/blocs/firm_bloc/firm_bloc.dart';

final getIt = GetIt.instance;

class AppGetIt {
  const AppGetIt._();
  static Future init() async {
    // presentation logic holder
    getIt.registerLazySingleton(() =>
        FirmBloc(getAllFirmsUseCase: getIt<GetAllFirmsUseCase>())
          ..add(GetAllFirmsEvent()));

    getIt.registerLazySingleton(() =>
        DocumentBloc(getAllDocumentsUseCase: getIt<GetAllDocumentsUseCase>())
          ..add(const GetAllDocumentsEvent()));

    getIt.registerFactory(() => DocumentFirmBloc(
          getDocumentsFirmsByIdUseCase: getIt<GetDocumentsFirmsByIdUseCase>(),
          getDocumentByIdUseCase: getIt<GetDocumentByIdUseCase>(),
        ));

    getIt.registerLazySingleton(() => FirmAllDocumentsBloc(
        getFirmAllDocumentsByIdUseCase:
            getIt<GetFirmAllDocumentsByIdUseCase>()));

    // user case
    getIt.registerLazySingleton(
        () => GetAllFirmsUseCase(repository: getIt<DocumentRepository>()));

    getIt.registerLazySingleton(
        () => GetAllDocumentsUseCase(repository: getIt<DocumentRepository>()));

    getIt.registerLazySingleton(() =>
        GetDocumentsFirmsByIdUseCase(repository: getIt<DocumentRepository>()));

    getIt.registerLazySingleton(
        () => GetDocumentByIdUseCase(repository: getIt<DocumentRepository>()));

    getIt.registerLazySingleton(() => GetFirmAllDocumentsByIdUseCase(
        repository: getIt<DocumentRepository>()));
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
