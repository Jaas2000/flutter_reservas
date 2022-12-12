import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_flutter/ui/blocs/CourtBloc/court_bloc.dart';

class ConfirmModal extends StatelessWidget {
  final String bookingId;
  const ConfirmModal({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).size.height * 0.3),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.all(20),
        height: 320,
        child: BlocBuilder<CourtBloc, CourtState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10),
                const Center(
                    child: Icon(
                  Icons.delete,
                  size: 80,
                )),
                const SizedBox(height: 10),
                const Text(
                  '¿Quieres eliminar esta reserva?',
                  style:
                      TextStyle(decoration: TextDecoration.none, fontSize: 16),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: ElevatedButton(
                          child: const Text('¡Eliminar!'),
                          onPressed: () {
                            context
                                .read<CourtBloc>()
                                .add(DeleteBooking(bookingId: bookingId));
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
