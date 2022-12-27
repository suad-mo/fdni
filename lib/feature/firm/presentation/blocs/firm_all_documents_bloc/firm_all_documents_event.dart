part of 'firm_all_documents_bloc.dart';

abstract class FirmAllDocumentsEvent extends Equatable {
  const FirmAllDocumentsEvent();

  @override
  List<Object> get props => [];
}

class GetFirmAllDocumentsByIdEvent extends FirmAllDocumentsEvent {
  final Firm firm;
  const GetFirmAllDocumentsByIdEvent({required this.firm});

  @override
  List<Object> get props => [firm];
}
