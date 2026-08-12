import '../../data/models/route_model.dart';

abstract class RoutesState {}

class RoutesInitial extends RoutesState {}

class RoutesLoading extends RoutesState {}

class RoutesLoaded extends RoutesState {
  final List<RouteModel> routes;
  RoutesLoaded(this.routes);
}

class RoutesError extends RoutesState {
  final String message;
  RoutesError(this.message);
}

class RouteActionLoading extends RoutesState {}

class RouteActionSuccess extends RoutesState {}
