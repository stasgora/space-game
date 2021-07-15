import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'logic/room/room_cubit.dart';
import 'logic/start_page/start_page_cubit.dart';
import 'pages/room_page.dart';
import 'pages/start_page.dart';
import 'services/connection_provider.dart';
import 'services/room/room_service.dart';
import 'services/room/socket_room_service.dart';
import 'utils/ui/theme_config.dart';

void main() {
  GetIt.I.registerSingleton(ConnectionProvider());
  GetIt.I.registerSingleton<RoomService>(SocketRoomService());

  runApp(SpaceGame());
}

class SpaceGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'End Space',
      theme: _createAppTheme(),
      themeMode: ThemeMode.light,
      initialRoute: '/start-page',
      routes: _createRoutes(),
    );
  }


  Map<String, WidgetBuilder> _createRoutes() {
    getParams(BuildContext context) => ModalRoute.of(context)?.settings.arguments;
    return {
      '/start-page': (ctx) => withCubit(StartPage(), StartPageCubit()),
      '/room-page': (ctx) => withCubit(RoomPage(), RoomCubit(getParams(ctx) as String)),
    };
  }

  Widget withCubit<CubitType extends Cubit>(Widget widget, CubitType cubit) {
    return BlocProvider<CubitType>(
      create: (context) => cubit,
      child: widget,
    );
  }

  ThemeData _createAppTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.mainColor,
      fontFamily: 'Lato',
      scaffoldBackgroundColor: AppColors.mainBackgroundColor,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: AppColors.darkTextColor), // Scaffold/appbar headline
        headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.darkTextColor), // Main headline before lists
        headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: AppColors.darkTextColor), //For headers inside list elements
        subtitle2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: AppColors.mediumTextColor), // Little subtitle for headline2
        bodyText1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.lightTextColor), // Classic body text on light background
        bodyText2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.darkTextColor), // Classic body text on color
        button: TextStyle(fontSize: 32.0, color: AppColors.lightTextColor, fontFamily: 'LuckiestGuy') // (Almost always white) button text
      ),
    );
  }
}
