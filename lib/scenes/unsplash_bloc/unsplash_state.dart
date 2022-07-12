part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashState {}

class UnsplashInitial extends UnsplashState {}

class UnsplashLoadingState extends UnsplashState{}

class UnsplashErrorState extends UnsplashState{
  final String errorData;

  UnsplashErrorState({required this.errorData});
}

class UnsplashHasDataState extends UnsplashState{
  final List<UnsplashModel> photoData;

  UnsplashHasDataState({required this.photoData});
}


