import 'package:clean_framework/clean_framework.dart';

class BookListGateway extends Gateway<BookListGatewayOutput, BookListRequest, SuccessResponse, BookListSuccessInput> {
  @override
  BookListRequest buildRequest(BookListGatewayOutput output) {
    return BookListRequest();
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookListSuccessInput onSuccess(SuccessResponse response) {
    return const BookListSuccessInput();
  }
}

class BookListGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class BookListSuccessInput extends SuccessInput {
  const BookListSuccessInput();
}

class BookListRequest extends Request {}
