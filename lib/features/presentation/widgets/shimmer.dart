import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade50,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Shimmer.fromColors(
                  period: const Duration(milliseconds: 1000),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 32,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1000),
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                color: Colors.white,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width* ,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
