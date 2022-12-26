import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fdni/core/dependency_injection/get_it.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';
import 'package:fdni/feature/firm/presentation/blocs/all_data_bloc/all_data_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_data_event.dart';
part 'current_data_state.dart';

class CurrentDataBloc extends Bloc<CurrentDataEvent, CurrentDataState> {
  // final firms = getIt.get<AllDataBloc>().state.getFirmById(idFirm);
  CurrentDataBloc() : super(CurrentDataInitialState()) {
    on<ChangeCurrentDataEvent>(_changeCurrentDataEventHandler);
  }

  FutureOr<void> _changeCurrentDataEventHandler(
      ChangeCurrentDataEvent event, Emitter<CurrentDataState> emit) {
    final currentFirm =
        getIt.get<AllDataBloc>().state.getFirmById(event.idFirm);

    final currentDocument =
        getIt.get<AllDataBloc>().state.getDocumentById(event.idDocument);

    emit(CurrentDataLoadedState(
        currentFirm: currentFirm, currentDocument: currentDocument));
  }
}
