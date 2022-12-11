import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/enums/firms.dart';
import '../../../domain/entities/firm_data_entity.dart';
import '../../../domain/use_cases/get_firm_all_documents_by_id.dart';

part 'firm_all_documents_event.dart';
part 'firm_all_documents_state.dart';

class FirmAllDocumentsBloc
    extends Bloc<FirmAllDocumentsEvent, FirmAllDocumentsState> {
  final GetFirmAllDocumentsByIdUseCase _getFirmAllDocumentsByIdUseCase;
  FirmAllDocumentsBloc({
    required GetFirmAllDocumentsByIdUseCase getFirmAllDocumentsByIdUseCase,
  })  : _getFirmAllDocumentsByIdUseCase = getFirmAllDocumentsByIdUseCase,
        super(FirmAllDocumentsInitialState()) {
    on<GetFirmAllDocumentsByIdEvent>(_getFirmAllDocumentsByIdEventHandler);
  }

  Future<void> _getFirmAllDocumentsByIdEventHandler(
    GetFirmAllDocumentsByIdEvent event,
    Emitter<FirmAllDocumentsState> emit,
  ) async {
    final firm = event.firm;
    emit(FirmAllDocumentsLoadingState());
    final either = await _getFirmAllDocumentsByIdUseCase(firm);
    either.fold(
      (failure) {
        emit(FirmAllDocumentsRetrievalErrorState(
          message: 'Error GetFirmAllDocumentsByIdEvent: $failure',
        ));
      },
      (documents) {
        //print(documents);
        emit(FirmAllDocumentsLoadedState(documents));
      },
    );
  }
}
