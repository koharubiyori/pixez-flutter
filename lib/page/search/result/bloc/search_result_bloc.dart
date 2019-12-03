import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pixez/models/recommend.dart';
import 'package:pixez/network/api_client.dart';
import './bloc.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
    final ApiClient client;

  SearchResultBloc(this.client);

  @override
  SearchResultState get initialState => InitialSearchResultState();

  @override
  Stream<SearchResultState> mapEventToState(
    SearchResultEvent event,
  ) async* {
   if (event is FetchEvent) {
      try {
        final response = await client.getSearchIllust(event.word);
        Recommend recommend = Recommend.fromJson(response.data);
        yield DataState(recommend.illusts, recommend.nextUrl);
      } catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e == null) {
          return;
        }
        print(e);
      }
    }
    if (event is LoadMoreEvent) {
      if (event.nextUrl != null) {
        try {
          final response = await client.getNext(event.nextUrl);
          Recommend recommend = Recommend.fromJson(response.data);
          final ill = event.illusts..addAll(recommend.illusts);
          print(ill.length);
          yield DataState(ill, recommend.nextUrl);
        } catch (e) {}
      } else {}
    }
  }
}
