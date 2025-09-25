import 'dart:async';

abstract class UseCase<Data, Params> {
  const UseCase();

  Future<Data> call(Params params);
}

class NoParams {}
