import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/core/book_external_interface.dart';
import 'package:dio/dio.dart';

final bookExternalInterfaceProvider = Provider<BookExternalInterface>(
  (context) => BookExternalInterface(dio: Dio()),
);
