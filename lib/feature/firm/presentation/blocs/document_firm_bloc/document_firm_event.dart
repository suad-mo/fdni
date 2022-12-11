part of 'document_firm_bloc.dart';

abstract class DocumentFirmEvent extends Equatable {
  const DocumentFirmEvent();

  @override
  List<Object> get props => [];
}

class GetAllDocumentsFirmsEvent extends DocumentFirmEvent {
  const GetAllDocumentsFirmsEvent();

  @override
  List<Object> get props => [];
}

class GetDocumentFirmByIdEvent extends DocumentFirmEvent {
  final String id;
  const GetDocumentFirmByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}
