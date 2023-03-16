import 'package:clean_framework/clean_framework.dart';

class BookDetailsViewModel extends ViewModel {
  const BookDetailsViewModel({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
