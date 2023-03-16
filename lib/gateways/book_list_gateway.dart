import 'package:clean_flutter/features/common/domain/book_entity.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/core/book_request.dart';
import 'package:clean_flutter/core/book_success_response.dart';

class BookListGateway
    extends Gateway<BookListGatewayOutput, BookListRequest, BookSuccessResponse, BookListSuccessInput> {
  @override
  BookListRequest buildRequest(BookListGatewayOutput output) {
    return BookListRequest(isbnList: output.isbnList);
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookListSuccessInput onSuccess(BookSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    final books = deserializer.getList(
      'books',
      converter: BookEntity.fromJson,
    );

    return BookListSuccessInput(books: books);
  }
}

class BookListGatewayOutput extends Output {
  const BookListGatewayOutput({required this.isbnList});

  final List<String> isbnList;

  @override
  List<Object?> get props => [isbnList];
}

class BookListSuccessInput extends SuccessInput {
  const BookListSuccessInput({required this.books});

  final List<BookEntity> books;
}

class BookListRequest extends GetBookRequest {
  @override
  String get resource => 'book';

  @override
  Map<String, dynamic> get queryParams => {
        'isbnList': isbnList.join(','),
      };

  final List<String> isbnList;

  BookListRequest({required this.isbnList});
}
