import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Widgets/news_list_item.dart';
import 'package:news_app/blocs/Internet/internet_bloc_bloc.dart';
import 'package:news_app/blocs/News/news_bloc_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('whole page build');
    return Scaffold(
      backgroundColor: const Color(0xff464646),
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
        title: Text(
          'HEADLINE',
          style: TextStyle(
            fontSize: 29.sp,
            color: const Color(0xffffffff),
            fontFamily: 'Roboto Slab',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<InternetBloc, InternetBlocState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Internet Connected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.lightGreen,
              ),
            );
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Internet Lost',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Check Your Connection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, internetState) {
          if (internetState is InternetGainedState) {
            BlocProvider.of<NewsBloc>(context).add(FetchNewsFromRepoEvent());
          }
          if (internetState is InternetLostState ||
              internetState is InternetInitialState) {
            BlocProvider.of<NewsBloc>(context).add(FetchNewsFromMemoryEvent());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: BlocBuilder<NewsBloc, NewsBlocState>(
              builder: (context, newsState) {
                // if (newsState is NewsInitialState) {
                if (newsState is NewsLoadingState) {
                  return Center(
                    child: Lottie.network(
                      "https://assets4.lottiefiles.com/packages/lf20_usmfx6bp.json",
                      animate: true,
                    ),
                  );
                }
                if (newsState is NewsLoadedState) {
                  return ListView.builder(
                    itemCount: newsState.newsList.length,
                    itemBuilder: ((context, index) =>
                        NewsListItem(news: newsState.newsList[index])),
                  );
                }
                if (newsState is NewsErrorState) {
                  return Center(
                    child: Text(newsState.errorMessage.toString()),
                  );
                }
                return Center(
                  child: Lottie.network(
                    "https://assets4.lottiefiles.com/packages/lf20_usmfx6bp.json",
                    animate: true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
