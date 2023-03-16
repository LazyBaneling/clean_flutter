import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_use_case.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookDetailsUseCase tests |', () {
    useCaseTest<BookDetailsUseCase, BookDetailsEntity, BookDetailsUIOutput>(
      'example',
      provider: bookDetailsUseCaseProvider,
      execute: (useCase) {
        useCase.updateId('test');
      },
      expect: () => [
        const BookDetailsUIOutput(id: 'test'),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          const BookDetailsEntity(id: 'test'),
        );
      },
    );
  });
}