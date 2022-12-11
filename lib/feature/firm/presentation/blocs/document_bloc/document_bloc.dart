import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:fdni/core/enums/document_sub_type.dart';
import 'package:fdni/core/enums/document_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/use_cases/get_all_documents.dart';
import '../../../domain/entities/document_entity.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetAllDocumentsUseCase _getAllDocumentsUseCase;
  DocumentBloc({
    required GetAllDocumentsUseCase getAllDocumentsUseCase,
  })  : _getAllDocumentsUseCase = getAllDocumentsUseCase,
        super(DocumentInitialState()) {
    on<GetAllDocumentsEvent>(_getAllDocumentsEventHandler);
  }

  FutureOr<void> _getAllDocumentsEventHandler(
    GetAllDocumentsEvent event,
    Emitter<DocumentState> emit,
  ) async {
    emit(DocumentLoadingState());
    final either = await _getAllDocumentsUseCase(NoParams());
    either.fold((failure) {
      emit(
        DocumentRetrievalErrorState(
          message: 'Error GetAllDocumentsEvent: $failure',
        ),
      );
    }, (documents) {
      documents.sort(
        (a, b) => b.idDocument.compareTo(a.idDocument),
      );
      emit(DocumentLoadedState(documents: documents));
    });
  }
}
