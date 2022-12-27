import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/document_sub_type.dart';
import '../../../../../core/enums/document_type.dart';
import '../../../../../core/enums/firm.dart';

part 'current_data_event.dart';
part 'current_data_state.dart';

class CurrentDataBloc extends Bloc<CurrentDataEvent, CurrentDataState> {
  CurrentDataBloc() : super(const CurrentDataInitialState()) {
    on<ChangeCurrentDataEvent>(_changeCurrentDataEventHandler);
  }

  Future<void> _changeCurrentDataEventHandler(
    ChangeCurrentDataEvent event,
    Emitter<CurrentDataState> emit,
  ) async {
    // final idFirm = event.idFirm;
    final idDocument = event.idDocument;
    final st = state;
    if (st is CurrentDataLoadedState) {
      final CurrentDataLoadedState x =
          st.copyWidthIdDocument(idDocument: idDocument!);
      emit(x);
    }
  }
}
