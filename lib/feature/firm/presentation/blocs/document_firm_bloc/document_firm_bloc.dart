import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fdni/core/enums/firms.dart';
import 'package:fdni/feature/firm/domain/entities/bar_data_entity.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/use_cases/get_document_by_id.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injection/get_it.dart';
import '../../../domain/entities/pie_data_entity.dart';
import '../../../domain/use_cases/get_documents_firms_by_id.dart';
import '../firm_bloc/firm_bloc.dart';

import '../../../domain/entities/document_firm_entity.dart';

part 'document_firm_event.dart';
part 'document_firm_state.dart';

class DocumentFirmBloc extends Bloc<DocumentFirmEvent, DocumentFirmState> {
  final GetDocumentsFirmsByIdUseCase _getDocumentsFirmsByIdUseCase;
  final GetDocumentByIdUseCase _getDocumentByIdUseCase;

  DocumentFirmBloc({
    required GetDocumentsFirmsByIdUseCase getDocumentsFirmsByIdUseCase,
    required GetDocumentByIdUseCase getDocumentByIdUseCase,
  })  : _getDocumentsFirmsByIdUseCase = getDocumentsFirmsByIdUseCase,
        _getDocumentByIdUseCase = getDocumentByIdUseCase,
        super(DocumentFirmInitialState()) {
    on<GetDocumentFirmByIdEvent>(_getDocumentFirmByIdEvent);
  }

  Future<void> _getDocumentFirmByIdEvent(
    GetDocumentFirmByIdEvent event,
    Emitter<DocumentFirmState> emit,
  ) async {
    final id = event.id;
    emit(DocumentFirmLoadingState());
    final either = await _getDocumentsFirmsByIdUseCase(id);
    final docEither = await _getDocumentByIdUseCase(id);
    // either.andThen(docEither);
    late DocumentEntity document;
    docEither.fold((failure) {
      emit(
        DocumentFirmRetrievalErrorState(
          message: 'Error GetDocumentFirmByIdEvent: $failure',
        ),
      );
    }, (doc) {
      document = doc;
    });

    either.fold((failure) {
      emit(
        DocumentFirmRetrievalErrorState(
          message: 'Error GetDocumentFirmByIdEvent: $failure',
        ),
      );
    }, (documents) {
      emit(DocumentFirmByIdLoadedState(
        listDocFirm: documents,
        document: document,
      ));
    });
  }
}
