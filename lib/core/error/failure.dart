import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

/// Represents a failure that can occur during an operation.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => <Object?>[message, cause];
}

/// Failure that happens when interacting with remote services.
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    this.statusCode,
    super.cause,
    super.stackTrace,
  });

  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[message, cause, statusCode];
}

/// Failure that originates from local cache or persistent storage access.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.cause, super.stackTrace});
}

/// Failure used when the underlying error cannot be categorised.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.cause,
    super.stackTrace,
  });
}

/// Failure for authentication problems (e.g. invalid credentials).
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.cause, super.stackTrace});
}

/// Failure originating from device location: GPS off or permission denied.
class LocationFailure extends Failure {
  const LocationFailure({
    required super.message,
    this.isPermanentlyDenied = false,
    super.cause,
    super.stackTrace,
  });

  /// True when permission is permanently denied — UI should offer "open settings".
  final bool isPermanentlyDenied;

  @override
  List<Object?> get props => <Object?>[message, cause, isPermanentlyDenied];
}

const _defaultFailureMessage = 'Terjadi Kesalahan';

/// Convert known exceptions into strongly typed [Failure] instances.
Failure mapExceptionToFailure(Object error, [StackTrace? stackTrace]) {
  if (error is Failure) return error;

  if (error is LocationServiceDisabledException) {
    return LocationFailure(
      message: 'Layanan lokasi (GPS) tidak aktif. Aktifkan terlebih dahulu.',
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is PermissionDeniedException) {
    final permanentlyDenied =
        error.message?.toLowerCase().contains('permanen') ?? false;
    return LocationFailure(
      message: error.message ?? 'Izin lokasi ditolak.',
      isPermanentlyDenied: permanentlyDenied,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is DioException) {
    final responseMessage = _extractDioMessage(error);
    return ServerFailure(
      message: responseMessage ?? _defaultFailureMessage,
      statusCode: error.response?.statusCode,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is SocketException) {
    return ServerFailure(
      message: 'Tidak ada koneksi internet',
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is String) {
    return UnexpectedFailure(
      message: error,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  return UnexpectedFailure(
    message: error.toString(),
    cause: error,
    stackTrace: stackTrace,
  );
}

String? _extractDioMessage(DioException exception) {
  final data = exception.response?.data;

  if (data is Map && data['message'] != null) {
    return data['message'].toString();
  }
  if (data is Map && data['errors'] != null) {
    final errors = data['errors'];
    if (errors is List && errors.isNotEmpty) {
      return errors.first.toString();
    }
    return errors.toString();
  }

  return exception.message;
}
