
// ignore_for_file: null_check_on_nullable_type_parameter

class Result<T> {
  final bool success;
  final T? data;
  final String? error;
  
  const Result.success(this.data) : success = true, error = null;
  
  const Result.failure(this.error) : success = false, data = null;
  
  bool get isSuccess => success;
  bool get isFailure => !success;
  
  T getDataOrThrow() {
    if (isSuccess && data != null) {
      return data!;
    }
    throw Exception(error ?? 'Unknown error');
  }
  
  T getDataOrDefault(T defaultValue) {
    return isSuccess && data != null ? data! : defaultValue;
  }
  
  void onSuccess(void Function(T data) callback) {
    if (isSuccess && data != null) {
      callback(data!);
    }
  }
  
  void onFailure(void Function(String error) callback) {
    if (isFailure && error != null) {
      callback(error!);
    }
  }
  
  @override
  String toString() {
    if (isSuccess) {
      return 'Result.success($data)';
    } else {
      return 'Result.failure($error)';
    }
  }
}