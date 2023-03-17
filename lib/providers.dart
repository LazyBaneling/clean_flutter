import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/index/domain/index_use_case.dart';
import 'package:clean_flutter/features/index/external_interface/book_collection_gateway.dart';
import 'package:clean_flutter/features/details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/details/external_interface/book_details_gateway.dart';
import 'package:clean_flutter/core/book/book_external_interface.dart';

final indexUseCaseProvider = UseCaseProvider.autoDispose(
  IndexUseCase.new,
);

final bookDetailsUseCaseProvider = UseCaseProvider<BookDetailsEntity, BookDetailsUseCase>(
  BookDetailsUseCase.new,
);

final bookCollectionGateway = GatewayProvider(
  BookCollectionGateway.new,
  useCases: [indexUseCaseProvider],
);

final bookDetailsGateway = GatewayProvider(
  BookDetailsGateway.new,
  useCases: [bookDetailsUseCaseProvider],
);

final bookExternalInterfaceProvider = ExternalInterfaceProvider(
  BookExternalInterface.new,
  gateways: [
    bookCollectionGateway,
    bookDetailsGateway,
  ],
);
