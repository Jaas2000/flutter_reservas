import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_flutter/data/database/dao/booking_dao.dart';
import 'package:prueba_flutter/data/services/database_service.dart';

part 'court_event.dart';
part 'court_state.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  CourtBloc()
      : super(const CourtState(
          firstLoad: true,
          isLoading: false,
          isError: false,
          bookings: [],
        )) {
    on<DeleteBooking>((event, emit) async {
      // Booking booking = await DatabaseService().booking(event.bookingId);
      print('is deleting');
      bool isDeleted = await DatabaseService().deleteBooking(event.bookingId);

      if (isDeleted) {
        List<BookingCourt> bookings = await DatabaseService().listBookings();
        emit(state.copyWith(bookings: bookings, firstLoad: false));
      }
    });

    on<FirstLoad>((event, emit) async {
      List<BookingCourt> bookings = await DatabaseService().listBookings();
      emit(state.copyWith(bookings: bookings, firstLoad: false));
    });
  }
}
