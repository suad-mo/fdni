part of 'current_firm_bloc.dart';

abstract class CurrentFirmState extends Equatable {
  const CurrentFirmState();

  FirmEntity? get currentFirm => null;

  @override
  List<Object> get props => [];
}

class CurrentFirmInitialState extends CurrentFirmState {}

class CurrentFirmLoadingState extends CurrentFirmState {}

class CurrentFirmLoadedState extends CurrentFirmState {
  final FirmEntity? _currentFirm;

  const CurrentFirmLoadedState({
    required FirmEntity? currentFirm,
  }) : _currentFirm = currentFirm;

  @override
  FirmEntity? get currentFirm => _currentFirm;
}
