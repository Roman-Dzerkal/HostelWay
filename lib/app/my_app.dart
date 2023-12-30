import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
    setStatus('Online');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else {
      setStatus('Offline');
    }
  }

  void setStatus(String status) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'status': status});
    }
  }

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
        providers: const [] /* [
          BlocProvider(
              lazy: false,
              create: (context) =>
                  AuthenticationBloc(authRepository: AuthorizationRepository())
                    ..add(AuthenticationInitialEvent())),
        ] */
        ,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
                // builder: FToastBuilder(),
                debugShowCheckedModeBanner: false,
                title: 'Hostelway',
                navigatorKey: widget.navigatorKey,
                home:
                    null /* BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationIsAuthenticated) {
                    if (state.authModel?.role == Role.client) {
                      return HomeClientView(
                          navigator: HomeClientNavigator(context));
                    } else {
                      return HomeHireworkerView(
                          navigator: HomeHireworkerNavigator(context));
                    }
                  } else if (state is AuthenticationIsUnthenticated) {
                    return const WelcomeView();
                  } else {
                    return const SplashView();
                  }
                },
              ), */
                );
          },
        ),
      ),
    );
  }
}
