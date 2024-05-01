class HomeState {
  const HomeState({
    this.loading = false,
  });

  final bool loading;

  HomeState copyWith({
    bool? loading,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
    );
  }
}
