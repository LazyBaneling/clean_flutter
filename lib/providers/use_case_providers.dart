import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_use_case.dart';

final bookListUseCaseProvider = UseCaseProvider(BookListUseCase.new);

final bookDetailsUseCaseProvider = UseCaseProvider(BookDetailsUseCase.new);
