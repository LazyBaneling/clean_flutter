import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';

class BookDetailsUseCase extends UseCase<BookDetailsEntity> {
  BookDetailsUseCase()
      : super(
          entity: const BookDetailsEntity(book: BookEntity()),
          transformers: [BookDetailsUIOutputTransformer()],
        );

  void updateBook(BookEntity book) {
    entity = entity.copyWith(book: book);
  }
}

class BookDetailsUIOutputTransformer extends OutputTransformer<BookDetailsEntity, BookDetailsUIOutput> {
  @override
  BookDetailsUIOutput transform(BookDetailsEntity entity) {
    return BookDetailsUIOutput(bookDetailsEntity: entity);
  }
}
