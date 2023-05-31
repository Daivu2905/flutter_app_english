import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new_demo/models/English_today.dart';
import 'package:flutter_app_new_demo/packages/quote/qoute_model.dart';
import 'package:flutter_app_new_demo/packages/quote/quote.dart';
import 'package:flutter_app_new_demo/page/all_words_page.dart';
import 'package:flutter_app_new_demo/page/show_more.dart';

import 'package:flutter_app_new_demo/values/app_assets.dart';
import 'package:flutter_app_new_demo/values/app_colors.dart';
import 'package:flutter_app_new_demo/values/app_styles.dart';
import 'package:flutter_app_new_demo/values/share_keys.dart';
import 'package:flutter_app_new_demo/widget/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'control_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];
  String quote = Quotes().getRandom().content!;

  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglisToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRamdom(len: len, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }

    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> __scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglisToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: __scaffoldKey,
      backgroundColor: AppColors.seCondColor,
      appBar: AppBar(
        backgroundColor: AppColors.seCondColor,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(
            color: AppColors.textColor,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () {
            __scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: size.height * 1 / 10,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '"$quote"',
                    style: AppStyles.h5.copyWith(
                      fontSize: 15,
                      color: AppColors.textColor,
                    ),
                  )),
              SizedBox(
                height: size.height * 2 / 3,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {});
                      _currentIndex = index;
                    },
                    itemCount: words.length > 5 ? 6 : words.length,
                    itemBuilder: (context, index) {
                      String firstLetter =
                          words[index].noun != null ? words[index].noun! : '';
                      firstLetter = firstLetter.substring(0, 1);
                      String LeftLetter =
                          words[index].noun != null ? words[index].noun! : '';
                      LeftLetter = LeftLetter.substring(1, LeftLetter.length);
                      String quoteDefault =
                          "Think of all the beauty still left around you and be happy";
                      String qoute = words[index].quote != null
                          ? words[index].quote!
                          : quoteDefault;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: AppColors.primaryColor,
                          elevation: 4,
                          child: InkWell(
                            onDoubleTap: () {
                              setState(() {
                                words[index].isFavorite =
                                    !words[index].isFavorite;
                              });
                            },
                            splashColor: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              // margin: const EdgeInsets.symmetric(vertical: 16),
                              child: index >= 5
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => AllwordsPagee(
                                                    words: words)));
                                      },
                                      child: Center(
                                        child: Text(
                                          'Show more',
                                          style: AppStyles.h3.copyWith(
                                              shadows: [
                                                const BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6)
                                              ]),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          // Container(
                                          //     alignment: Alignment.centerRight,
                                          //     padding: const EdgeInsets.all(5),
                                          //     child: Image.asset(
                                          //       AppAssets.heart,
                                          //       color: words[index].isFavorite
                                          //           ? Colors.red
                                          //           : Colors.white,
                                          //     )),
                                          LikeButton(
                                            onTap: (bool isLiked) async {
                                              setState(() {
                                                words[index].isFavorite =
                                                    !words[index].isFavorite;
                                              });
                                              return words[index].isFavorite;
                                            },
                                            isLiked: words[index].isFavorite,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            size: 42,
                                            circleColor: CircleColor(
                                                start: Color.fromARGB(
                                                    255, 57, 214, 128),
                                                end: Color.fromARGB(
                                                    255, 109, 58, 226)),
                                            bubblesColor: BubblesColor(
                                              dotPrimaryColor: Color.fromARGB(
                                                  255, 63, 213, 178),
                                              dotSecondaryColor: Color.fromARGB(
                                                  255, 169, 209, 58),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Icon(
                                                Icons.favorite,
                                                color: isLiked
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 42,
                                              );
                                            },
                                          ),
                                          RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  text: firstLetter,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          FontFamily.sen,
                                                      fontSize: 95,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black38,
                                                            offset:
                                                                Offset(3, 6),
                                                            blurRadius: 6)
                                                      ]),
                                                  children: [
                                                    TextSpan(
                                                      text: LeftLetter,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              FontFamily.sen,
                                                          fontSize: 55,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          shadows: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black38,
                                                                offset: Offset(
                                                                    3, 6),
                                                                blurRadius: 6)
                                                          ]),
                                                    )
                                                  ])),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 24),
                                            child: AutoSizeText(
                                              '"$qoute"',
                                              maxFontSize: 26,
                                              style: AppStyles.h4.copyWith(
                                                  color: AppColors.textColor,
                                                  letterSpacing: 1),
                                            ),
                                          )
                                        ]),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              _currentIndex >= 5
                  ? buildShowMore()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: size.height * 1 / 14,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return buildIndicator(
                                    index == _currentIndex, size);
                              }),
                        ),
                      ),
                    )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getEnglisToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
          child: Container(
        color: AppColors.lighBlue,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: Text(
              'Yorl mind',
              style: AppStyles.h3.copyWith(color: AppColors.textColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: AppButton(
                label: 'Favories',
                onTap: () {
                  print('dmmmmmmmm');
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: AppButton(
                label: 'Your Control',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ControlPage()));
                }),
          )
        ]),
      )),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 3 : 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lighBlue : AppColors.lightgrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
        ],
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: AppColors.primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AllWordsPage(
                          words: words,
                        )));
          },
          overlayColor: MaterialStateProperty.all(Colors.black26),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyles.h5,
            ),
          ),
        ),
      ),
    );
  }
}
