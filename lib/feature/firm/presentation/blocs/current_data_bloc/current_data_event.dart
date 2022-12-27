part of 'current_data_bloc.dart';

abstract class CurrentDataEvent extends Equatable {
  const CurrentDataEvent();

  @override
  List<Object?> get props => [];
}

class ChangeCurrentDataEvent extends CurrentDataEvent {
  final int? idFirm;
  final String? idDocument;

  const ChangeCurrentDataEvent({
    this.idFirm,
    this.idDocument,
  });

  @override
  List<Object?> get props => [idFirm, idDocument];
}

class ChangeCurrentFirmEvent extends CurrentDataEvent {
  final Firm firm;

  const ChangeCurrentFirmEvent({
    required this.firm,
  });

  @override
  List<Object?> get props => [firm];
}

class ChangeCurrentYearEvent extends CurrentDataEvent {
  final int year;

  const ChangeCurrentYearEvent({
    required this.year,
  });

  @override
  List<Object?> get props => [year];
}

class ChangeCurrentIdDocumentEvent extends CurrentDataEvent {
  final String idDocument;

  const ChangeCurrentIdDocumentEvent({
    required this.idDocument,
  });

  @override
  List<Object?> get props => [idDocument];
}
