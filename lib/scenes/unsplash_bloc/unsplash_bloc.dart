import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../common/app_text.dart';
import '../../core/model/unsplash_model.dart';
import '../../core/repository/unsplash_repository.dart';

part 'unsplash_event.dart';
part 'unsplash_state.dart';

class UnsplashBloc extends Bloc<UnsplashEvent, UnsplashState> {
  UnsplashBloc() : super(UnsplashInitial()) {
    on<UnsplashInitialPageEvent>(_onUnsplashInitialPage);
    on<UnsplashNextPageEvent>(_onUnsplashNextPage);
    on<UnsplashUpdatePageEvent>(_onUnsplashUpdatePage);
  }

  int page = 1;

  Future<void> _onUnsplashInitialPage(
      UnsplashInitialPageEvent event, Emitter<UnsplashState> emit) async {
    emit(UnsplashLoadingState());
    try{
      List<UnsplashModel> photoData = await UnsplashRepository().getDataList(page: page);
      emit(UnsplashHasDataState(photoData: photoData));
    } on Exception catch (e) {
      emit(UnsplashErrorState(errorData: '${AppText.errorData}: $e'));
    }
  }

  Future<void> _onUnsplashNextPage(
      UnsplashNextPageEvent event, Emitter<UnsplashState> emit) async {
    page++;
    List<UnsplashModel> photoData = await UnsplashRepository().getDataList(page: page);
    emit(UnsplashHasDataState(photoData: photoData));
  }

  Future<void> _onUnsplashUpdatePage(UnsplashUpdatePageEvent event, Emitter<UnsplashState> emit) async{
    emit(UnsplashLoadingState());
    page = 1;
    await Future.delayed(const Duration(seconds: 1));
    UnsplashRepository().clearCache();
    List<UnsplashModel> photoData = await UnsplashRepository().getDataList(page: page);
    emit(UnsplashHasDataState(photoData: photoData));
  }
}
