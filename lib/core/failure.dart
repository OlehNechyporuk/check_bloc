class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class FailureMessages {
  static const String noInternetConnection = 'Немає підключення до Інтернету';
  static const String noServerResponseMessage = 'Немає відповіді від серевере';
  static const String badResponseFormat = 'Помилки формату відповіді';
  static const String emptyLoginOrPassword = 'Введіть логін та пароль';
  static const String emptyApiKey = 'Empty Api Key';
  static const String emptySum = 'Введіть суму';
  static const String shiftIsClosed = 'Зміна закрита';
  static const String productNotFound = 'Не знайдено';
}
