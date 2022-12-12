part of 'court_bloc.dart';

class CourtState extends Equatable {
  final bool isLoading;
  final bool firstLoad;
  final bool isError;
  final List<BookingCourt> bookings;

  const CourtState({
    required this.isLoading,
    required this.firstLoad,
    required this.isError,
    required this.bookings,
  });

  CourtState copyWith({
    bool? isLoading,
    bool? firstLoad,
    bool? isError,
    List<BookingCourt>? bookings,
  }) {
    return CourtState(
      isLoading: isLoading ?? this.isLoading, 
      firstLoad: firstLoad ?? this.firstLoad, 
      isError: isError ?? this.isError, 
      bookings: bookings ?? this.bookings,
    );
  }

  @override
  List<Object> get props => [
    isLoading, 
    firstLoad,
    isError, 
    bookings,
  ];

  @override
  String toString() => 
    'RegisterState { isLoading: $isLoading, firstLoad: $firstLoad, isError: $isError}';
}
