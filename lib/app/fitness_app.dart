import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fittrack/app/app_controller.dart';
import 'package:fittrack/features/dashboard/bloc/today_bloc.dart';
import 'package:fittrack/features/dashboard/presentation/home_screen.dart';
import 'package:fittrack/features/notifications/bloc/notification_bloc.dart';
import 'package:fittrack/features/water/bloc/water_bloc.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppController();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: controller.todayBloc),
        BlocProvider.value(value: controller.waterBloc),
        BlocProvider.value(value: controller.notificationBloc),
      ],
      child: MaterialApp(
        title: 'FitTrack',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        home: const HomeScreen(),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF6C63FF),
        secondary: Color(0xFF3B82F6),
        surface: Color(0xFF1E1E2E),
        background: Color(0xFF0F0F1A),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F0F1A),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      fontFamily: 'SF Pro Display',
      useMaterial3: true,
    );
  }
}
