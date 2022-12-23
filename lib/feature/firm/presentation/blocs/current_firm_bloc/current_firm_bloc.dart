import 'package:equatable/equatable.dart';
import 'package:fdni/core/dependency_injection/get_it.dart';
import 'package:fdni/feature/firm/presentation/blocs/all_data_bloc/all_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/firm_entity.dart';

part 'current_firm_event.dart';
part 'current_firm_state.dart';

class CurrentFirmBloc extends Bloc<CurrentFirmEvent, CurrentFirmState> {
  CurrentFirmBloc() : super(CurrentFirmInitialState()) {
    on<ChangeCurrentFirmEvent>(_changeCurrentFirmEventHandler);
  }

  Future<void> _changeCurrentFirmEventHandler(
    ChangeCurrentFirmEvent event,
    Emitter<CurrentFirmState> emit,
  ) async {
    final idFirm = event.idFirm;
    final FirmEntity? currentFirm =
        getIt.get<AllDataBloc>().state.getFirmById(idFirm);
    emit(CurrentFirmLoadedState(currentFirm: currentFirm));
  }
}
