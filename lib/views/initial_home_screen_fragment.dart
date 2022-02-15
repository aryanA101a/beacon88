import 'package:flutter/material.dart';

class InitialHomeScreenFragment extends StatelessWidget {
  const InitialHomeScreenFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: Image.asset("assets/images/location.png")),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Get a passkey that you can share",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.0),
                child: Text.rich(
                  TextSpan(text: "Tap ", children: [
                    TextSpan(
                      text: "New Beacon ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          "to get a passkey that you can send to people that you permit to track you",
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
