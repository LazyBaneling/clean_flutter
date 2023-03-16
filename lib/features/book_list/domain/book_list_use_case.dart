import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';

class BookListUseCase extends UseCase<BookListEntity> {
  BookListUseCase()
      : super(
          entity: const BookListEntity(),
          transformers: [BookListUIOutputTransformer()],
        );

  void updateBooks(List<BookEntity> books) {
    entity = entity.copyWith(books: books);
  }
}

class BookListUIOutputTransformer extends OutputTransformer<BookListEntity, BookListUIOutput> {
  @override
  BookListUIOutput transform(BookListEntity entity) {
    return BookListUIOutput(bookList: entity);
  }
}
