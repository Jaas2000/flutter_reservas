part of 'new_booking_bloc.dart';

class NewBookingState extends Equatable {
  final bool isLoading;
  final bool firstLoad;
  final bool isSaved;
  final bool isError;
  final String errorMessage;
  final String name;
  final String date;
  final String weather;
  final String courtId;
  final List<Court> courts;

  const NewBookingState({
    required this.isLoading,
    required this.firstLoad,
    required this.isSaved,
    required this.isError,
    required this.errorMessage,
    required this.name,
    required this.date,
    required this.weather,
    required this.courtId,
    required this.courts,
  });

  NewBookingState copyWith({
    bool? isLoading,
    bool? firstLoad,
    bool? isSaved,
    bool? isError,
    String? errorMessage,
    String? name,
    String? date,
    String? weather,
    String? courtId,
    List<Court>? courts,
  }) {
    return NewBookingState(
      isLoading: isLoading ?? this.isLoading, 
      firstLoad: firstLoad ?? this.firstLoad, 
      isSaved: isSaved ?? this.isSaved,
      isError: isError ?? this.isError, 
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name, 
      date: date ?? this.date, 
      weather: weather ?? this.weather,
      courtId: courtId ?? this.courtId,
      courts: courts ?? this.courts,
    );
  }

  @override
  List<Object> get props => [
    isLoading, 
    firstLoad,
    isSaved, 
    isError, 
    errorMessage, 
    name, 
    date, 
    weather,
    courtId,
    courts,
  ];

  @override
  String toString() => 
    'RegisterState { isLoading: $isLoading, firstLoad: $firstLoad, isError: $isError}';
}

