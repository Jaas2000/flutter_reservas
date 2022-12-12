part of 'court_bloc.dart';

abstract class CourtEvent {}

class FirstLoad extends CourtEvent {
  final bool firstLoad;
  FirstLoad({required this.firstLoad});
}

class DeleteBooking extends CourtEvent {
  final String bookingId;
  DeleteBooking({required this.bookingId});
}
