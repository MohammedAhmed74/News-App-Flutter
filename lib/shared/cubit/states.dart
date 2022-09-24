class NewsState {}

class InitialNewsState extends NewsState {}

class BottomNavState extends NewsState {}

class GetDataState extends NewsState {}

class BusinessLoadingState extends NewsState {}

class GetBusinessDataState extends NewsState {}

class CatchBusinessErrorState extends NewsState {
  CatchBusinessErrorState(String error);
}

class SportsLoadingState extends NewsState {}

class GetSportsDataState extends NewsState {}

class CatchSportsErrorState extends NewsState {
  CatchSportsErrorState(String error);
}

class ScienceLoadingState extends NewsState {}

class GetScienceDataState extends NewsState {}

class CatchScienceErrorState extends NewsState {
  CatchScienceErrorState(String error);
}

class ChangeThemeState extends NewsState {}

class ChangeSearchState extends NewsState {}
