import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/groups/create_group_screen.dart';
import 'features/content/content_library_screen.dart';
import 'features/projects/project_list_screen.dart';
import 'features/projects/create_project_screen.dart';

  /* 
  // TODO: Substitua pelos seus dados do Supabase
  await Supabase.initialize(
    url: 'SUA_URL_SUPABASE_AQUI',
    anonKey: 'SUA_ANON_KEY_SUPABASE_AQUI',
  );
  */

  runApp(const ProviderScope(child: TeacherWebApp()));
}

class TeacherWebApp extends StatelessWidget {
  const TeacherWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam English - Teacher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WebLoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/groups/new': (context) => const CreateGroupScreen(),
        '/content': (context) => const ContentLibraryScreen(),
        '/projects': (context) => const ProjectListScreen(),
        '/projects/new': (context) => const CreateProjectScreen(),
      },
    );
  }
}
