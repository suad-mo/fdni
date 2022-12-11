import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/use_cases/get_all_firms.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/cupertino.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/firm_entity.dart';

part 'firm_event.dart';
part 'firm_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';

class FirmBloc extends Bloc<FirmEvent, FirmState> {
  final GetAllFirmsUseCase _getAllFirmsUseCase;

  FirmBloc({
    required GetAllFirmsUseCase getAllFirmsUseCase,
  })  : _getAllFirmsUseCase = getAllFirmsUseCase,
        super(FirmInitialState()) {
    on<GetAllFirmsEvent>(_getAllFirmsEventHandler);
    on<ChangeSelectFirmByIdEvent>(_changeSelectFirmByIdEventHandler);
  }

  Future<void> _getAllFirmsEventHandler(
    GetAllFirmsEvent event,
    Emitter<FirmState> emit,
  ) async {
    emit(FirmLoadingState());
    final either = await _getAllFirmsUseCase(NoParams());
    either.fold((failure) {
      emit(
        FirmRetrievalErrorState(
          message: _mapFailureToMessage(failure),
        ),
      );
    }, (firms) {
      final selectFirms = firms
          .map((e) => FirmSelected(idFirm: e.idFirm, name: e.name))
          .toList();
      emit(FirmLoadedState(selectFirms: selectFirms, firms: firms));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    late final String failureMessage;

    switch (failure.runtimeType) {
      case ServerFailure:
        failureMessage = serverFailureMessage;
        break;

      case CacheFailure:
        failureMessage = cacheFailureMessage;
        break;

      default:
        failureMessage = 'Unexpected error';
        break;
    }

    return failureMessage;
  }

  Future<void> _changeSelectFirmByIdEventHandler(
      ChangeSelectFirmByIdEvent event, Emitter<FirmState> emit) async {
    if (state is FirmLoadedState) {
      final id = event.id;
      final firms = event.selectedFirms;
      try {
        emit(FirmChangeSelectedFirmsState(id: id, selectFirms: firms));
        final selectFirms = firms.map((e) {
          if (id != e.idFirm) {
            return e;
          } else {
            e.changeSelected();
            return e;
          }
        }).toList();

        emit(FirmLoadedState(selectFirms: selectFirms));
      } catch (e) {
        emit(
          const FirmRetrievalErrorState(
            message: 'Error ...',
          ),
        );
      }
    }
  }
}

// ignore: must_be_immutable
class FirmSelected extends FirmEntity {
  bool selected;

  FirmSelected({
    required super.idFirm,
    required super.name,
    this.selected = false,
  });

  void changeSelected() {
    selected = !selected;
  }
}
