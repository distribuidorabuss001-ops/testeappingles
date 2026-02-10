import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/tracks_lessons/tracks_screen.dart';
import 'features/tracks_lessons/lesson_runner_screen.dart';
import 'features/pronunciation/pronunciation_lab_screen.dart';
import 'features/projects/project_dashboard_screen.dart';
import 'features/projects/project_submission_screen.dart';

  /* 
  // TODO: Substitua pelos seus dados do Supabase
  await Supabase.initialize(
    url: 'SUA_URL_SUPABASE_AQUI',
    anonKey: 'SUA_ANON_KEY_SUPABASE_AQUI',
  );
  */

  runApp(const ProviderScope(child: StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam English - Student',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/tracks': (context) => const TracksScreen(),
        '/lesson/123': (context) => const LessonRunnerScreen(lessonId: '123'),
        '/pronunciation': (context) => const PronunciationLabScreen(),
        '/projects': (context) => const ProjectDashboardScreen(),
        '/projects/submit': (context) => const ProjectSubmissionScreen(),
      },
    );
  }
}
