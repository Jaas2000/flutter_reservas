import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_flutter/ui/pages/global_widgets/booking_card.dart';

import '../blocs/CourtBloc/court_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtBloc, CourtState>(
      builder: (context, state) {
        if (state.firstLoad) {
          context.read<CourtBloc>().add(FirstLoad(firstLoad: false));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Canchas"),
          ),
          body: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.bookings.length,
              itemBuilder: (BuildContext context, int ind) {
                return BookingCard(
                  booking: state.bookings[ind],
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'new_booking');
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
