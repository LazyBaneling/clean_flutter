import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/details/external_interface/book_details_gateway.dart';

class BookDetailsUseCase extends UseCase<BookDetailsEntity> {
  BookDetailsUseCase()
      : super(
          entity: const BookDetailsEntity(),
          transformers: [BookDetailsUIOutputTransformer()],
        );

  void fetchBookDetails(String isbn) {
    request<BookDetailsGatewayOutput, BookDetailsSuccessInput>(
      BookDetailsGatewayOutput(isbn: isbn),
      onSuccess: (success) {
        final bookDetails = success.bookDetails;

        return entity.copyWith(
          title: bookDetails.title,
          authors: bookDetails.authors,
          isbn: bookDetails.isbn,
          cover: bookDetails.cover,
          publishDate: bookDetails.publishDate,
          numberOfPages: bookDetails.numberOfPages,
        );
      },
      onFailure: (failure) => entity,
    );
  }
}

class BookDetailsUIOutputTransformer extends OutputTransformer<BookDetailsEntity, BookDetailsUIOutput> {
  @override
  BookDetailsUIOutput transform(BookDetailsEntity entity) {
    return BookDetailsUIOutput(
      title: entity.title,
      authors: entity.authors,
      isbn: entity.isbn,
      cover: entity.cover,
      publishDate: entity.publishDate,
      numberOfPages: entity.numberOfPages,
    );
  }
}
