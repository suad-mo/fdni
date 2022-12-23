import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_data_event.dart';
part 'current_data_state.dart';

class CurrentDataBloc extends Bloc<CurrentDataEvent, CurrentDataState> {
  CurrentDataBloc() : super(CurrentDataInitialState()) {
    on<ChangeCurrentDataEvent>(_changeCurrentDataEventHandler);
  }

  FutureOr<void> _changeCurrentDataEventHandler(
      ChangeCurrentDataEvent event, Emitter<CurrentDataState> emit) {}
}
