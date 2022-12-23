part of 'current_firm_bloc.dart';

abstract class CurrentFirmEvent extends Equatable {
  const CurrentFirmEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentFirmEvent extends CurrentFirmEvent {
  final int idFirm;

  const ChangeCurrentFirmEvent({
    required this.idFirm,
  });
}
