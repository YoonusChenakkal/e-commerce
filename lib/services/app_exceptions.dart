class AppExceptions implements Exception {
  final message;
  final prefix;
  AppExceptions([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? messge]) : super(messge, 'Error Occured : ');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? messge]) : super(messge, 'Invalid Request : ');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? messge])
      : super(messge, 'Unauthorized Request : ');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? messge]) : super(messge, 'Invalid Input : ');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? messge]) : super(messge, 'Not Found : ');
}

class ServerErrorException extends AppExceptions {
  ServerErrorException([String? messge]) : super(messge, 'Server Error :');
}
