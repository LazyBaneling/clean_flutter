import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookListUseCase tests |', () {
    useCaseTest<BookListUseCase, BookListEntity, BookListUIOutput>(
      'example',
      provider: bookListUseCaseProvider,
      execute: (useCase) {
        useCase.updateId('test');
      },
      expect: () => [
        const BookListUIOutput(id: 'test'),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          const BookListEntity(id: 'test'),
        );
      },
    );
  });
}
