import 'package:equatable/equatable.dart';
import 'package:fdni/core/use_cases/use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/document_sub_type.dart';
import '../../../../../core/enums/document_type.dart';
import '../../../../../core/enums/firms.dart';
import '../../../domain/entities/bar_data_entity.dart';
import '../../../domain/entities/document_entity.dart';
import '../../../domain/entities/document_firm_entity.dart';
import '../../../domain/entities/firm_entity.dart';
import '../../../domain/entities/pie_data_entity.dart';
import '../../../domain/use_cases/get_all_documents.dart';
import '../../../domain/use_cases/get_all_documents_firms.dart';
import '../../../domain/use_cases/get_all_firms.dart';

part 'all_data_event.dart';
part 'all_data_state.dart';

class AllDataBloc extends Bloc<AllDataEvent, AllDataState> {
  final GetAllDocumentsFirmsUseCase _getAllDocumentsFirmsUseCase;
  final GetAllDocumentsUseCase _getAllDocumentsUseCase;
  final GetAllFirmsUseCase _getAllFirmsUseCase;

  AllDataBloc({
    required GetAllDocumentsFirmsUseCase getAllDocumentsFirmsUseCase,
    required GetAllDocumentsUseCase getAllDocumentsUseCase,
    required GetAllFirmsUseCase getAllFirmsUseCase,
  })  : _getAllDocumentsFirmsUseCase = getAllDocumentsFirmsUseCase,
        _getAllDocumentsUseCase = getAllDocumentsUseCase,
        _getAllFirmsUseCase = getAllFirmsUseCase,
        super(AllDataInitial()) {
    on<GetAllDataEvent>(_getAllDataEventHandler);
  }

  Future<void> _getAllDataEventHandler(
      GetAllDataEvent event, Emitter<AllDataState> emit) async {
    List<FirmEntity> firms = [];
    List<DocumentEntity> documents = [];
    List<DocumentFirmEntity> allData = [];
    emit(AllDataLoadingState());
    final eitherFirms = await _getAllFirmsUseCase(NoParams());
    eitherFirms.fold((failure) {
      emit(AllDataRetrievalErrorState());
    }, (f) {
      firms = f;
      emit(AllDataFirmsLoadedState(firms: firms));
    });

    final eitherDocs = await _getAllDocumentsUseCase(NoParams());
    eitherDocs.fold((failure) {
      emit(AllDataRetrievalErrorState());
    }, (docs) {
      documents = docs;
      emit(AllDataFirmsAndDocumentLoadedState(
        firms: firms,
        documents: documents,
      ));
    });

    final eitherData = await _getAllDocumentsFirmsUseCase(NoParams());
    eitherData.fold((failure) {
      emit(AllDataRetrievalErrorState());
    }, (data) {
      allData = data;
      emit(AllDataLoadedState(
        firms: firms,
        documents: documents,
        allData: allData,
      ));
    });
  }
}
