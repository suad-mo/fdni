part of 'current_data_bloc.dart';

abstract class CurrentDataEvent extends Equatable {
  const CurrentDataEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentDataEvent extends CurrentDataEvent {
  final int? idFirm;
  final String? idDocument;

  const ChangeCurrentDataEvent({
    this.idFirm,
    this.idDocument,
  });
}
