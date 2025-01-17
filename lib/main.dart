import 'package:bloc/bloc.dart';
import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/repository/master_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_health_app/core/bloc_util/app_bloc_observer.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/themes/app_theme.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/navigator_observer.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DataProvider.init();
  Bloc.observer = AppBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MasterDataRepository())
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => MasterDataBloc(
                masterDataRepository:
                    RepositoryProvider.of<MasterDataRepository>(context))),
      ], child: const MyApp())));
  // Set the status bar color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Change to your desired color
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness:
        Brightness.light, // For light text/icons on the status bar
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Health',
      navigatorObservers: [MyNavigatorObserver()],
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
