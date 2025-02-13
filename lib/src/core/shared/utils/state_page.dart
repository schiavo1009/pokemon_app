abstract class StatePage<T> {}

class StateSuccess<T> extends StatePage<T> {
  final T? data;
  final bool isLoadingMore;
  StateSuccess({this.data, this.isLoadingMore = false});
}

class StateEmpty<T> extends StatePage<T> {}

class StateError<T> extends StatePage<T> {
  String? message;
  Exception? exception;

  StateError({this.message, this.exception});
}

class StateLoading<T> extends StatePage<T> {}
