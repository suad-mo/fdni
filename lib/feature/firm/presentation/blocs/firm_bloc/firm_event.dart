part of 'firm_bloc.dart';

abstract class FirmEvent extends Equatable {
  const FirmEvent();

  @override
  List<Object> get props => [];
}

class GetAllFirmsEvent extends FirmEvent {}

class ChangeSelectFirmByIdEvent extends FirmEvent {
  final List<FirmSelected> selectedFirms;
  final int id;

  const ChangeSelectFirmByIdEvent({
    required this.id,
    required this.selectedFirms,
  });

  @override
  List<Object> get props => [
        id,
        selectedFirms,
      ];
}
