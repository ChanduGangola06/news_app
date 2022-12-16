import 'package:flutter/material.dart';
import 'package:news_app/Models/news_data_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends StatelessWidget {
  final News news;
  const NewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        news.imageUrl ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black87,
                        Colors.black12,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                top: 300,
                left: 24,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title ?? 'title',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: const Color(0xfff2f2f2),
                          fontSize: 29.sp,
                          fontFamily: 'Roboto Slab'),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 64,
                left: 24,
                right: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news.source ?? 'source',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: const Color(0xfff2f2f2),
                            fontFamily: 'Roboto Slab',
                          ),
                        ),
                        Text(
                          news.publishedDate?.substring(0, 10) ?? 'date',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: const Color(0xfff2f2f2),
                            fontFamily: 'Roboto Slab',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      news.description ?? 'description',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xffbababa),
                        fontFamily: 'Roboto Slab',
                      ),
                      maxLines: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
