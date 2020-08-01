class AppState<T> {
  /// Status of the APP
  Status status;
  /// Data from Server
  T data;
  /// Loading Or Error message
  String message;


/// When App is Fetching Data 
AppState.loading(this.message) : status = Status.LOADING;

/// When App Completed Fetching Data 
AppState.completed(this.data) : status = Status.COMPLETED;

/// When App is Having Error
AppState.error(this.message) : status = Status.ERROR;
  

}

enum Status { LOADING, COMPLETED, ERROR }