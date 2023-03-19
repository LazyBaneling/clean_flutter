import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/domain/index_ui_output.dart';
import 'package:clean_flutter/features/index/domain/index_use_case.dart';
import 'package:clean_flutter/features/index/models/book_model.dart';
import 'package:clean_flutter/features/index/presentation/index_presenter.dart';
import 'package:clean_flutter/features/index/presentation/index_view_model.dart';
import 'package:clean_flutter/providers.dart';

void main() {
  group('IndexPresenter tests |', () {
    presenterTest<IndexViewModel, IndexUIOutput, IndexUseCase>(
      'creates proper view model',
      create: (builder) => IndexPresenter(builder: builder),
      overrides: [
        indexUseCaseProvider.overrideWith(IndexUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            books: [
              BookModel(
                title: 'Book 1',
                authors: ['Author 1'],
                isbn: '123',
                cover: 'cover1',
                publishDate: '2021-01-01',
                numberOfPages: 100,
              ),
              BookModel(
                title: 'Book 2',
                authors: ['Author 2'],
                isbn: '456',
                cover: 'cover2',
                publishDate: '2022-01-01',
                numberOfPages: 200,
              ),
            ],
          ),
        );
      },
      expect: () => [
        isA<IndexViewModel>().having((vm) => vm.books, 'books', []),
        isA<IndexViewModel>().having(
          (vm) => vm.books.map((b) => b.title),
          'books',
          ['Book 1', 'Book 2'],
        ),
      ],
    );

    presenterTest<IndexViewModel, IndexUIOutput, IndexUseCase>(
      'shows success snack bar if refreshing succeeds',
      create: (builder) => IndexPresenter(builder: builder),
      overrides: [
        indexUseCaseProvider.overrideWith(IndexUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: IndexStatus.loaded,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Refreshed books successfully!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<IndexViewModel, IndexUIOutput, IndexUseCase>(
      'shows failure snack bar if refreshing fails',
      create: (builder) => IndexPresenter(builder: builder),
      overrides: [
        indexUseCaseProvider.overrideWith(IndexUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: IndexStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed refreshing books!'),
          findsOneWidget,
        );
      },
    );
  });
}

class IndexUseCaseFake extends IndexUseCase {
  @override
  Future<void> fetchBooks({bool isRefresh = false}) async {}
}
