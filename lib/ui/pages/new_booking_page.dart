import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';
import 'package:prueba_flutter/ui/pages/global_widgets/alerts.dart';

import '../blocs/NewBookingBloc/new_booking_bloc.dart';

class NewBookingPage extends StatefulWidget {
  const NewBookingPage({Key? key}) : super(key: key);

  @override
  State<NewBookingPage> createState() => _NewBookingPageState();
}

class _NewBookingPageState extends State<NewBookingPage> {
  TextEditingController dateField = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewBookingBloc, NewBookingState>(
      listener: (context, state) {
        if (state.isSaved) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<NewBookingBloc>().add(OnSaved(isSaved: false));
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          });
        }
        if (state.isError) {
          print('INTENTOS LLENOS');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showError(context, state.errorMessage);
            context
                .read<NewBookingBloc>()
                .add(OnError(isError: false, errorMessage: ''));
          });
        }
      },
      child: BlocBuilder<NewBookingBloc, NewBookingState>(
        builder: (context, state) {
          if (state.firstLoad) {
            context.read<NewBookingBloc>().add(FirstLoad(firstLoad: false));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Agendar"),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    child: state.courts.isEmpty
                        ? const SizedBox()
                        : DropdownButton(
                            underline: const SizedBox(),
                            // value: state.courts[0].id.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            isExpanded: true,
                            hint: Text(
                              state.courts
                                  .where((Court element) =>
                                      element.id.toString() == state.courtId)
                                  .first
                                  .name,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: state.courts.map((Court items) {
                              return DropdownMenuItem(
                                value: items.id.toString(),
                                child: Text(items.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<NewBookingBloc>()
                                  .add(EditCourt(courtId: value.toString()));
                            },
                          ),
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("El clima es: "),
                        Text(state.weather),
                      ],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      context.read<NewBookingBloc>().add(EditName(name: value));
                    },
                    decoration: const InputDecoration(
                        labelText: "Nombre",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black54,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: const DatePickerTheme(
                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          minTime: DateTime.now().add(const Duration(days: 1)),
                          maxTime:
                              DateTime.now().add(const Duration(days: 1000)),
                          onConfirm: (date) {
                        context.read<NewBookingBloc>().add(EditDate(
                            date: DateFormat('dd/MM/yyyy')
                                .format(date)
                                .toString()));
                        dateField.text =
                            DateFormat('dd/MM/yyyy').format(date).toString();
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                    child: TextFormField(
                      controller: dateField,
                      keyboardType: TextInputType.text,
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Fecha',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black54,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        context.read<NewBookingBloc>().add(SaveBooking());
                      },
                      child: const Text(
                        "Registrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
