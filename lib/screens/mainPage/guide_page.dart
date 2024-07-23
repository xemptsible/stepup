import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  YoutubePlayerController youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=FOLTnk8WUg4")
          .toString());
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hướng đẫn"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: YoutubePlayer(controller: youtubeController)),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      String text = "";

                      switch (index) {
                        case 0:
                          text = "Chức năng 1: Đăng nhập & đăng ký";
                          break;
                        case 1:
                          text = "Chức năng 2: Tìm kiểm sản phẩm";
                          break;
                        case 2:
                          text = "Chức năng 3: Thêm sản phẩm vào giỏ hàng";
                          break;
                        case 3:
                          text = "Chức năng 4: Thanh Toán";
                          break;
                      }
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              switch (index) {
                                case 0:
                                  youtubeController
                                      .seekTo(Duration(seconds: 0));
                                  break;
                                case 1:
                                  youtubeController
                                      .seekTo(Duration(seconds: 220));
                                  break;
                                case 2:
                                  youtubeController
                                      .seekTo(Duration(seconds: 320));
                                  break;
                                case 3:
                                  youtubeController
                                      .seekTo(Duration(seconds: 500));
                                  break;
                              }
                            });
                          },
                          child: FunctionSelect(
                              context, text, selectedIndex == index));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget FunctionSelect(BuildContext context, String text, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            border: isSelected ? null : Border.all(width: 0.5),
            color: isSelected ? Colors.blue : Colors.white),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        )),
  );
}
