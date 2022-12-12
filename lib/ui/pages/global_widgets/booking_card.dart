import 'package:flutter/material.dart';
import 'package:prueba_flutter/data/database/dao/booking_dao.dart';
import 'package:prueba_flutter/ui/pages/global_widgets/alerts.dart';

class BookingCard extends StatelessWidget {
  final BookingCourt booking;

  const BookingCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking.courtName),
              const SizedBox(
                height: 10,
              ),
              Text(booking.weather),
            ],
          ),
          Column(
            children: [
              Text(booking.name),
              const SizedBox(
                height: 10,
              ),
              Text(booking.date),
            ],
          ),
          InkWell(
            onTap: () => showConfirm(context, booking.id.toString()),
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
