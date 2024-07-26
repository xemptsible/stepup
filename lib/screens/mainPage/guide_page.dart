import 'package:flutter/material.dart';
import 'package:stepup/app.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late YoutubePlayerController _youtubeController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=FOLTnk8WUg4")
          .toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hướng dẫn"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _youtubeController.pause();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const App()));
            },
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: YoutubePlayer(controller: _youtubeController)),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
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
                          text = "Chức năng 2: Tìm kiếm sản phẩm";
                          break;
                        case 2:
                          text = "Chức năng 3: Thêm sản phẩm vào giỏ hàng";
                          break;
                        case 3:
                          text = "Chức năng 4: Thanh toán";
                          break;
                      }
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              switch (index) {
                                case 0:
                                  _youtubeController
                                      .seekTo(const Duration(seconds: 0));
                                  break;
                                case 1:
                                  _youtubeController
                                      .seekTo(const Duration(seconds: 220));
                                  break;
                                case 2:
                                  _youtubeController
                                      .seekTo(const Duration(seconds: 320));
                                  break;
                                case 3:
                                  _youtubeController
                                      .seekTo(const Duration(seconds: 500));
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
        padding: const EdgeInsets.all(30),
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
