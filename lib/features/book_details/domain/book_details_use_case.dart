import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';

class BookDetailsUseCase extends UseCase<BookDetailsEntity> {
  BookDetailsUseCase()
        : super(
            entity: const BookDetailsEntity(),
            transformers: [BookDetailsUIOutputTransformer()],
          );

  void updateId(String id) {
    entity = entity.copyWith(id: id);
  }
}

class BookDetailsUIOutputTransformer extends OutputTransformer<BookDetailsEntity, BookDetailsUIOutput> {
  @override
  BookDetailsUIOutput transform(BookDetailsEntity entity) {
    return BookDetailsUIOutput(id: entity.id);
  }
}
