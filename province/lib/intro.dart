import 'package:flutter/material.dart';
import 'package:province/pages/provinces.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xff5C6795),
            ),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/location-2.png',
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Province Search',
                      style: TextStyle(fontSize: 25, color: Color(0xffF6C00F)),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Province()));
                      },
                      child: Container(
                        height: 40,
                        width: 260,
                        decoration: BoxDecoration(
                            color: Color(0xff5C6795),
                            border: Border.all(color: Color(0xffE7E9EE)),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '                     เริ่ม',
                              style: TextStyle(
                                  color: Color(0xffE7E9EE), fontSize: 20),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffE7E9EE),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
