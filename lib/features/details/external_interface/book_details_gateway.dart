import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/core/book/book_request.dart';
import 'package:clean_flutter/core/book/book_success_response.dart';
import 'package:clean_flutter/features/details/models/book_details_model.dart';

class BookDetailsGateway
    extends Gateway<BookDetailsGatewayOutput, BookDetailsRequest, BookSuccessResponse, BookDetailsSuccessInput> {
  @override
  BookDetailsRequest buildRequest(BookDetailsGatewayOutput output) {
    return BookDetailsRequest(isbn: output.isbn);
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookDetailsSuccessInput onSuccess(BookSuccessResponse response) {
    String isbn = response.data.keys.first;
    return BookDetailsSuccessInput(
      bookDetails: BookDetailsModel.fromJson(isbn, response.data[isbn]),
    );
  }
}

class BookDetailsGatewayOutput extends Output {
  const BookDetailsGatewayOutput({required this.isbn});

  final String isbn;

  @override
  List<Object?> get props => [isbn];
}

class BookDetailsSuccessInput extends SuccessInput {
  const BookDetailsSuccessInput({required this.bookDetails});

  final BookDetailsModel bookDetails;
}

class BookDetailsRequest extends GetBookRequest {
  BookDetailsRequest({required this.isbn});

  final String isbn;

  @override
  String get resource => 'books';

  @override
  Map<String, dynamic> get queryParams => {
        'bibkeys': 'ISBN:$isbn',
        'jscmd': 'data',
        'format': 'json',
      };
}
