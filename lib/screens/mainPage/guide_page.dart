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
              "https://www.youtube.com/watch?v=RZuLdLFhKtA")
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hướng dẫn"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _youtubeController.pause();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                // width: MediaQuery.of(context).size.width * 0.9,
                child: YoutubePlayer(controller: _youtubeController)),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    String text = "";

                    switch (index) {
                      case 0:
                        text = "Chức năng 1: Đăng nhập & đăng ký";
                        break;
                      case 1:
                        text = "Chức năng 2: Thêm sản phẩm vào giỏ hàng";
                        break;
                      case 2:
                        text = "Chức năng 3: Thanh toán";
                        break;
                      case 3:
                        text = "Chức năng 4: Sử thông tin người dùng";
                        break;
                      case 4:
                        text = "Chức năng 5: Tìm kiếm sản phẩm";
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
                                    .seekTo(const Duration(seconds: 39));
                                break;
                              case 2:
                                _youtubeController
                                    .seekTo(const Duration(seconds: 74));
                                break;
                              case 3:
                                _youtubeController.seekTo(
                                    const Duration(minutes: 2, seconds: 37));
                                break;
                              case 4:
                                _youtubeController.seekTo(
                                    const Duration(minutes: 3, seconds: 12));
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
