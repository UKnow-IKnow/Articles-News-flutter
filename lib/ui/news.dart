import 'package:articles_news/model/news_data.dart';
import 'package:articles_news/utils/common_function.dart';
import 'package:articles_news/utils/constants.dart';
import 'package:articles_news/ui/news_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget NewsCard(BuildContext context, Articles article) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
    child: GestureDetector(
      onTap: () {
        teleportWithArguments(
          context,
          NewsDetails.routeName,
          article,
        );
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: article.url.toString(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        const Color(0xff000000).withOpacity(0.85),
                        const Color(0xff000000).withOpacity(0.4),
                        const Color(0xff232323).withOpacity(0.2),
                      ],
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(13)),
                child: myCachedNetworkImage(article.urlToImage.toString(), 2),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      black.withOpacity(0.85),
                      black.withOpacity(0.4),
                      black.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(
                        size: 20,
                        maxLine: 3,
                        article.title.toString(),
                        color: text),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          myText(
                              size: 20,
                              fontWeight: FontWeight.bold,
                              article.source!.name.toString(),
                              color: text2),
                          const SizedBox(width: 5),
                          myText(
                              size: 12,
                              article.publishedAt.toString().substring(0, 10),
                              color: text2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

newsCardShimmer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[500] as Color,
      highlightColor: Colors.grey[100] as Color,
      enabled: true,
      child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Container(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 8),
                          child: Container(
                            height: 16,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(color: Colors.amber[100]),
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 2, bottom: 20),
                          child: Container(
                            alignment: Alignment.center,
                            height: 16,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(color: Colors.amber[100]),
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 16,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(color: Colors.amber[100]),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )),
    ),
  );
}
