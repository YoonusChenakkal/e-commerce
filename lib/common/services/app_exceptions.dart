class AppExceptions implements Exception {
  final message;
  final prefix;
  AppExceptions([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix : $message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Error Occured');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request : ');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message]) : super(message, 'Not Found');
}

class ServerErrorException extends AppExceptions {
  ServerErrorException([String? message]) : super(message, 'Server Error');
}
