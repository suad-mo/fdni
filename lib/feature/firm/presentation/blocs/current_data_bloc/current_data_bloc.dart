import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';
import 'package:flutter/material.dart';

part 'current_data_event.dart';
part 'current_data_state.dart';

class CurrentDataBloc extends Bloc<CurrentDataEvent, CurrentDataState> {
  CurrentDataBloc() : super(CurrentDataInitial()) {
    on<CurrentDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
