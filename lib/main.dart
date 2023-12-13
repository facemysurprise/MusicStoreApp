import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/data/repositories/shop_repository.dart';
import 'package:flutter_application_firebase/core/generated/codegen_loader.g.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_state.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:flutter_application_firebase/presentation/screens/Home_screen.dart';
import 'package:flutter_application_firebase/presentation/screens/Login_Screen.dart';
import 'package:flutter_application_firebase/presentation/screens/Splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/firebase_options.dart'; 
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
      path: 'assets/translation', 
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
    ),);
}

class MyApp extends StatelessWidget {
  final InstrumentRepository instrumentRepository = InstrumentRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<ShopBloc>(
          create: (context) => ShopBloc(repository: instrumentRepository), 
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(), 
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return SplashScreen(); 
            } else if (state is Authenticated) {
              return BottomNavBar(); 
            } else {
              return LoginPage(); 
            }
          },
        ),
      ),
    );
  }
}