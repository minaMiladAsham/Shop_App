abstract class SearchScreenStates {}

class SearchScreenInitialState extends SearchScreenStates {}

class SearchScreenLoadingState extends SearchScreenStates {}

class SearchScreenSuccessState extends SearchScreenStates {}

class SearchScreenErrorState extends SearchScreenStates {
  final String error;
  SearchScreenErrorState(this.error);
}