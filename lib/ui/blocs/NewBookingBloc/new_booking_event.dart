part of 'new_booking_bloc.dart';

abstract class NewBookingEvent {}

class FirstLoad extends NewBookingEvent {
  final bool firstLoad;
  FirstLoad({required this.firstLoad});
}

class EditName extends NewBookingEvent {
  final String name;
  EditName({required this.name});
}

class EditDate extends NewBookingEvent {
  final String date;
  EditDate({required this.date});
}

class EditWeather extends NewBookingEvent {
  final String weather;
  EditWeather({required this.weather});
}

class EditCourt extends NewBookingEvent {
  final String courtId;
  EditCourt({required this.courtId});
}

class SaveBooking extends NewBookingEvent {
  SaveBooking();
}

class OnError extends NewBookingEvent {
  final bool isError;
  final String errorMessage;
  OnError({required this.isError, required this.errorMessage});
}

class OnSaved extends NewBookingEvent {
  final bool isSaved;
  OnSaved({required this.isSaved});
}
