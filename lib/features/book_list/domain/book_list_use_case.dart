import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';

class BookListUseCase extends UseCase<BookListEntity> {
  BookListUseCase()
        : super(
            entity: const BookListEntity(),
            transformers: [BookListUIOutputTransformer()],
          );

  void updateId(String id) {
    entity = entity.copyWith(id: id);
  }
}

class BookListUIOutputTransformer extends OutputTransformer<BookListEntity, BookListUIOutput> {
  @override
  BookListUIOutput transform(BookListEntity entity) {
    return BookListUIOutput(id: entity.id);
  }
}
