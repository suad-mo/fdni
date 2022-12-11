part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class GetAllDocumentsEvent extends DocumentEvent {
  const GetAllDocumentsEvent();

  @override
  List<Object> get props => [];
}

class GetDocumentByIdEvent extends DocumentEvent {
  final String id;
  const GetDocumentByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}
