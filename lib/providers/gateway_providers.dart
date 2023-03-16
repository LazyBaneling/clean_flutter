import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/gateways/book_list_gateway.dart';

final bookListGatewayProvider = Provider<BookListGateway>(
  (context) => BookListGateway(),
);
