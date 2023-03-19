import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/domain/index_ui_output.dart';
import 'package:clean_flutter/features/index/external_interface/book_collection_gateway.dart';
import 'package:clean_flutter/features/index/models/book_model.dart';

class IndexUseCase extends UseCase<IndexEntity> {
  IndexUseCase()
      : super(
          entity: const IndexEntity(),
          transformers: [
            IndexUIOutputTransformer(),
          ],
        );

  Future<void> fetchBooks({bool isRefresh = false}) async {
    if (!isRefresh) {
      entity = entity.copyWith(status: IndexStatus.loading);
    }

    await request<BookCollectionGatewayOutput, BookCollectionSuccessInput>(
      BookCollectionGatewayOutput(),
      onSuccess: (success) {
        final books = success.bookIdentities.map(_resolveBook);

        return entity.copyWith(
          books: books.toList(growable: false),
          status: IndexStatus.loaded,
          isRefresh: isRefresh,
        );
      },
      onFailure: (failure) {
        return entity.copyWith(
          status: IndexStatus.failed,
          isRefresh: isRefresh,
        );
      },
    );

    if (isRefresh) {
      entity = entity.copyWith(isRefresh: false, status: IndexStatus.loaded);
    }
  }

  BookModel _resolveBook(BookIdentity book) {
    return BookModel(
      title: book.title,
      authors: book.authors,
      isbn: book.isbn,
      cover: book.cover,
      publishDate: book.publishDate,
      numberOfPages: book.numberOfPages,
    );
  }
}

class IndexUIOutputTransformer extends OutputTransformer<IndexEntity, IndexUIOutput> {
  @override
  IndexUIOutput transform(IndexEntity entity) {
    return IndexUIOutput(
      books: entity.books.toList(growable: false),
      status: entity.status,
      isRefresh: entity.isRefresh,
    );
  }
}
