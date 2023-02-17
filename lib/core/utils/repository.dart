import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../error/app_exceptions.dart';
import '../error/failure.dart';
import 'app_log.dart';

abstract class Repository {

  final Logger appLog = appLogger(Repository);

  Future<Either<Failure, T>> makeRequest<T>(
      Future<T> request, {
        Duration? duration,
        Future<T> Function()? onTimeOut,
      }) async {
    try {
      final T response = await request.timeout(
          duration ?? const Duration(seconds: 30), onTimeout: () async {
        if (onTimeOut != null) {
          return onTimeOut();
        }
        throw TimeoutException(null, duration);
      });
      return right(response);
    } on FetchDataException catch (exception) {
      return left(Failure(
          message: exception.message));
    } on TimeoutException catch (_) {

      return left(Failure(message: 'Request Timeout'));
    } on AppException catch (exception) {
      return left(Failure(
          message: exception.message));
    } catch (error, _) {
      appLog.e(error.toString(),);
      return left(
         Failure(message: 'Something went wrong technically.'),
      );
    }
  }

 /* Future<Either<Failure, T>> makeLocalRequest<T>(
      Future<T?> Function() request) async {
    try {
      final T? response = await request();
      if (response != null) {
        return right(response);
      } else {
        throw CacheException('Couldn\'t find cached data.');
      }
    } on CacheException catch (exception) {
      return left(
        Failure.server(
          message: exception.message ?? 'Unable to load cache data.',
        ),
      );
    } catch (error, stackTrace) {
      AppLog.e(
        error.toString(),
        stackTrace,
      );
      return left(
        const Failure.generic(message: 'Something went wrong locally.'),
      );
    }
  }*/
}
