import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';
import 'package:prueba_flutter/data/database/database.dart';
import 'package:prueba_flutter/ui/blocs/CourtBloc/court_bloc.dart';
import 'package:prueba_flutter/ui/blocs/NewBookingBloc/new_booking_bloc.dart';
import 'package:prueba_flutter/ui/pages/home_page.dart';
import 'package:prueba_flutter/ui/pages/new_booking_page.dart';

void main() async {
  await loadEnvVars();
  await checkDatabase();
  runApp(const MyApp());
}

checkDatabase() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final courtDao = database.courtDao;
  final courts = await courtDao.listCourts();

  if (courts.isEmpty) {
    final courtA = Court(id: 1, name: 'Campo A');
    final courtB = Court(id: 2, name: 'Campo B');
    final courtC = Court(id: 3, name: 'Campo C');
    await courtDao.insertCourt(courtA);
    await courtDao.insertCourt(courtB);
    await courtDao.insertCourt(courtC);
  }

  final courtsTemp = await courtDao.listCourts();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CourtBloc()),
        BlocProvider(create: (_) => NewBookingBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'new_booking': (context) => const NewBookingPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}

Future loadEnvVars() async {
  await dotenv.load(
    fileName: '.env',
  );
}
