import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';
import 'package:prueba_flutter/data/services/database_service.dart';

import '../../../data/services/weather_service.dart';
import '../../../domain/entities/weather_entity.dart';

part 'new_booking_event.dart';
part 'new_booking_state.dart';

class NewBookingBloc extends Bloc<NewBookingEvent, NewBookingState> {
  NewBookingBloc()
      : super(const NewBookingState(
          firstLoad: true,
          isLoading: false,
          isSaved: false,
          isError: false,
          errorMessage: '',
          name: '',
          date: '',
          weather: '',
          courtId: '1',
          courts: [],
        )) {
    on<NewBookingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FirstLoad>((event, emit) async {
      final data = await WeatherService().getData(state.courtId);
      Weather weatherResult = Weather.fromJson(data);
      List<Court> courts = await DatabaseService().listCourts();

      emit(state.copyWith(
        firstLoad: event.firstLoad,
        isLoading: false,
        isError: false,
        errorMessage: '',
        weather: weatherResult.weather![0].main,
        courts: courts,
      ));
    });

    on<EditName>((event, emit) => emit(state.copyWith(name: event.name)));

    on<OnError>((event, emit) => emit(state.copyWith(
        isError: event.isError, errorMessage: event.errorMessage)));

    on<OnSaved>((event, emit) => emit(state.copyWith(isSaved: event.isSaved)));

    on<EditDate>((event, emit) => emit(state.copyWith(date: event.date)));

    on<EditCourt>((event, emit) async {
      emit(state.copyWith(courtId: event.courtId));
      final data = await WeatherService().getData(event.courtId);

      Weather weatherResult = Weather.fromJson(data);

      emit(state.copyWith(weather: weatherResult.weather![0].main));
    });

    on<EditWeather>((event, emit) {
      emit(state.copyWith(weather: event.weather));
    });

    on<SaveBooking>((event, emit) async {
      final countBooking =
          await DatabaseService().countBookings(state.courtId, state.date);

      if (countBooking >= 3) {
        emit(state.copyWith(isError: true, errorMessage: 'Reservas llenas'));
        return;
      }
      bool isSaved = await DatabaseService()
          .saveBooking(state.name, state.date, state.weather, state.courtId);
      if (isSaved) {
        emit(state.copyWith(isSaved: true));
      } else {
        emit(state.copyWith(isError: true));
      }
    });
  }
}
