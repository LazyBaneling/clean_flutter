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
            BookSearchInputTransformer(),
            LastViewedBookInputTransformer(),
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
      title: book.title.toUpperCase(),
      authors: book.authors,
      isbn: book.isbn,
      cover: book.cover,
      publishDate: book.publishDate,
      numberOfPages: book.numberOfPages,
    );
  }
}

class BookSearchInput extends Input {
  const BookSearchInput({required this.title});

  final String title;
}

class IndexUIOutputTransformer extends OutputTransformer<IndexEntity, IndexUIOutput> {
  @override
  IndexUIOutput transform(IndexEntity entity) {
    final filteredBooks = entity.books.where(
      (book) {
        final bookTitle = book.title.toLowerCase();
        return bookTitle.contains(entity.bookTitleQuery.toLowerCase());
      },
    );

    return IndexUIOutput(
      books: filteredBooks.toList(growable: false),
      status: entity.status,
      isRefresh: entity.isRefresh,
      lastViewedBook: entity.lastViewedBook,
    );
  }
}

class BookSearchInputTransformer extends InputTransformer<IndexEntity, BookSearchInput> {
  @override
  IndexEntity transform(IndexEntity entity, BookSearchInput input) {
    return entity.copyWith(bookTitleQuery: input.title);
  }
}

class LastViewedBookInput extends Input {
  const LastViewedBookInput({required this.title});

  final String title;
}

class LastViewedBookInputTransformer extends InputTransformer<IndexEntity, LastViewedBookInput> {
  @override
  IndexEntity transform(IndexEntity entity, LastViewedBookInput input) {
    return entity.copyWith(lastViewedBook: input.title);
  }
}
