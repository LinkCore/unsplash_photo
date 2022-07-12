part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashEvent {}

class UnsplashInitialPageEvent extends UnsplashEvent{}

class UnsplashNextPageEvent extends UnsplashEvent{}

class UnsplashUpdatePageEvent extends UnsplashEvent{}
