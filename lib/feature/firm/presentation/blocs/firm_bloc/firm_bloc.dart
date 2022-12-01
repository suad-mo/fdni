import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fdni/core/use_cases/use_cases.dart';
import 'package:fdni/feature/firm/domain/use_cases/get_all_firms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      emit(FirmLoadedState(firms: firms));
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
}
