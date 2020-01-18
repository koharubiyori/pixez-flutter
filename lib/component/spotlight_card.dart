import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixez/models/spotlight_response.dart';
import 'package:pixez/page/soup/soup_page.dart';

class SpotlightCard extends StatelessWidget {
  final SpotlightArticle spotlight;
 static const platform = const MethodChannel('samples.flutter.dev/battery');
  const SpotlightCard({Key key, this.spotlight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () async {
//         final int result = await platform.invokeMethod('getBatteryLevel');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return SoupPage(url: spotlight.articleUrl,spotlight:spotlight);
          }));
        },
        child: Container(
          height: 230,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 160.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ListTile(
                        title: Text(
                          spotlight.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          spotlight.pureTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: spotlight.thumbnail,
                      httpHeaders: {
                        "referer": "https://app-api.pixiv.net/",
                        "User-Agent": "PixivIOSApp/5.8.0"
                      },
                      fit: BoxFit.cover,
                      height: 150.0,
                      width: 150.0,
                    ),
                    height: 150.0,
                    width: 150.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}