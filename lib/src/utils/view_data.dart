import 'package:pokedex_sprout/src/utils/failure_response.dart';

enum ViewState {
  initial,
  loading,
  loaded,
  loadMore,
  error,
  backgroundFetch,
  hasData,
  noData,
  loadNoData,
}

extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;

  bool get isInitial => this == ViewState.initial;

  bool get isBackgroundFetch => this == ViewState.backgroundFetch;

  bool get isError => this == ViewState.error;

  bool get isHasData => this == ViewState.hasData;

  bool get isLoaded => this == ViewState.loaded;

  bool get isLoadMore => this == ViewState.loadMore;

  bool get isNoData => this == ViewState.noData;

  bool get isLoadNoData => this == ViewState.loadNoData;
}

class ViewData<T> {
  final ViewState status;
  final T? data;
  final String? message;
  final FailureResponse? errors;

  const ViewData({
    this.status = ViewState.initial,
    this.message,
    this.data,
    this.errors,
  });

  ViewData.loading({
    this.status = ViewState.loading,
    this.message,
    this.data,
    this.errors,
  });

  ViewData.initial({
    this.status = ViewState.initial,
    this.message,
    this.data,
    this.errors,
  });

  ViewData.backgroundFetch({
    this.status = ViewState.backgroundFetch,
    this.message,
    this.data,
    this.errors,
  });

  ViewData.loaded(
    this.data, {
    this.status = ViewState.loaded,
    this.message,
    this.errors,
  });

  ViewData.loadMore(
    this.data, {
    this.status = ViewState.loadMore,
    this.message,
    this.errors,
  });

  ViewData.error(
    this.message, {
    this.status = ViewState.error,
    this.data,
    this.errors,
  });

  ViewData.loadNoData({
    this.status = ViewState.loadNoData,
    this.message,
    this.data,
    this.errors,
  });

  ViewData.noData({
    this.status = ViewState.noData,
    this.message,
    this.data,
    this.errors,
  });

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data \n Errors : $errors";
  }
}
