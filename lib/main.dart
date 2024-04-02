import 'package:clean_architecture_rivaan/core/secrets/app_secrets.dart';
import 'package:clean_architecture_rivaan/core/theme/theme.dart';
import 'package:clean_architecture_rivaan/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_rivaan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_rivaan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_rivaan/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPage(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
