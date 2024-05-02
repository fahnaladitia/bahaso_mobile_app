abstract class UseCase<T> {
  Future<T> call();
}

abstract class UseCaseWithParam<T, P> {
  Future<T> call(P param);
}
