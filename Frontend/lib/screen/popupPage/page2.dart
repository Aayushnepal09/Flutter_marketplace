import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 3;
              });
            },
            children: [
              buildPage(
                  title: "Welcome to KinBech",
                  desc:
                      "A digital marketplace where people can nuy and sell tgeir product",
                  image: "assets/images/startpage.png"),
              buildPage(
                  title:
                      "A digital marketplace where people can nuy and sell tgeir product ",
                  desc:
                      "A digital marketplace where people can nuy and sell tgeir product",
                  image: "assets/images/startpage.png"),
              buildPage(
                  title: "Different types of art",
                  desc:
                      "A digital marketplace where people can nuy and sell tgeir product",
                  image: "assets/images/startpage.png"),
              buildPage(
                  title: "Buy or sell anything",
                  desc:
                      "A digital marketplace where people can nuy and sell tgeir product",
                  image: "assets/images/startpage.png"),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor: const Color.fromARGB(255, 38, 189, 88),
                      minimumSize: const Size.fromHeight(60)),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, "/login");
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isWalkthroughShown", true);
                  },
                ),
              )
            : Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(3);
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.grey.shade300,
                            activeDotColor:
                                const Color.fromARGB(255, 38, 189, 88)),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text("NEXT")),
                  ],
                ),
              ),
      ),
    );
  }
}

Widget buildPage({
  required String title,
  required String desc,
  required String image,
}) =>
    Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 38, 189, 88)),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              desc,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
