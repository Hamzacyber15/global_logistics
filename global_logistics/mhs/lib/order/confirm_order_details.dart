import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';

class ConfirmOrderDetails extends StatefulWidget {
  const ConfirmOrderDetails({super.key});

  @override
  State<ConfirmOrderDetails> createState() => _ConfirmOrderDetailsState();
}

class _ConfirmOrderDetailsState extends State<ConfirmOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Preview"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          child: SizedBox(
            height: 230,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.forklift,
                    color: AppTheme.orangeColor,
                    size: 42,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   "WMC-71",
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold,
                          //       color: AppTheme.blackColor),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: AppTheme.orangeColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Exp Time : ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "5:00",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Cold Store Shop : ",
                          style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "WMC-71",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Equipment : ",
                          style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Fork Lift",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Storage : ",
                          style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Cold Storage",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Block : ",
                          style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "E",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Area : ",
                          style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "CSE-06",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Image.asset(
                  //   'assets/images/fork_lift.jpg',
                  //   height: 60,
                  //   width: 100,
                  //   scale: 1,
                  //   fit: BoxFit.fill,
                  // ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {}, //count == 0 ? register : null,
                      child: const Text(
                        'Confirm Order',
                      ),
                    ),
                  ],
                ),
                // const Divider(
                //   endIndent: 5,
                //   indent: 10,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
