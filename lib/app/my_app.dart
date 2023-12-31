import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/enums/role_enums.dart';
import 'package:hostelway/features/welcome/welcome_view/welcome_view.dart';
import 'package:hostelway/views/home/home_guest_view.dart';
import 'package:hostelway/views/home/home_manager_view.dart';
import 'package:hostelway/views/home/navigation/home_guest_navigator.dart';
import 'package:hostelway/views/home/navigation/home_manager_navigator.dart';
import 'package:hostelway/views/splash/splash_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.navigatorKey});
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // setStatus('Online');
  }

  /* @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else {
      setStatus('Offline');
    }
  } */

  /* void setStatus(String status) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'status': status});
    }
  } */

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: const [] /* [
        RepositoryProvider(
            create: (context) => PostsRepository(
                postsService: PostsService(), socialService: SocialService())),
        RepositoryProvider(
            create: (context) => UsersRepository(
                searchService: UserSearchService(),
                userService: UserService(),
                paymentService: PaymentService())),
        RepositoryProvider(
            create: (context) => OrdersRepository(
                ordersService: OrdersService(),
                chatService: ChatService(),
                paymentService: PaymentService(),
                notificationServices: NotificationService())),
        RepositoryProvider(
            create: (context) =>
                RewiewsRepository(reviewsService: RewiewsService()))
      ] */
      ,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              lazy: false,
              create: (context) =>
                  AuthenticationBloc(authRepository: AuthorizationRepository())
                    ..add(AuthenticationInitialEvent())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844), // iPhone 13 screen size
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              // builder: FToastBuilder(),
              debugShowCheckedModeBanner: false,
              title: 'Hostelway',
              navigatorKey: widget.navigatorKey,
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationIsAuthenticated) {
                    if (state.authModel?.role == Role.guest) {
                      return HomeGuestView(
                          navigator: HomeGuestNavigator(context));
                    } else {
                      return HomeManagerView(
                          navigator: HomeManagerNavigator(context));
                    }
                  } else if (state is AuthenticationIsUnthenticated) {
                    return const WelcomeView();
                  } else {
                    return const SplashView();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
