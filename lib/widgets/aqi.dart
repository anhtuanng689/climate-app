import 'package:flutter/material.dart';
import 'package:flutter_weather/models/aqi.dart';
import 'package:intl/intl.dart';
import '../helper/utils.dart';
import '../widgets/progressBar.dart';
import '../widgets/detailProgressBar.dart';

class Aqi extends StatelessWidget {
  final wData;

  Aqi({this.wData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 20),
          child: Text(
            'Air Quality',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2475,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(6, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        '${wData.aqi}',
                        style: TextStyle(
                          fontSize: 43,
                          color: AqiString.colorFromHexss(
                              AqiString.getAqiColor(wData.aqi)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AqiString.getAqiLevel(wData.aqi),
                          style: _style1.copyWith(fontSize: 23),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          AqiString.getAqiRecommend(wData.aqi),
                          style: _style2.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DetailProgressBar(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 20,
                radius: 0,
                assetsLimit: 500,
                assets: [
                  MyAssets(size: 50, num: 0),
                  MyAssets(size: 50, num: 50),
                  MyAssets(size: 50, num: 100),
                  MyAssets(size: 50, num: 150),
                  MyAssets(size: 100, num: 200),
                  MyAssets(size: 100, num: 300),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              MyAssetsBar(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 10,
                background: colorFromHex("CFD8DC"),
                radius: 0,
                assetsLimit: 500,
                assets: [
                  MyAsset(size: 50, color: colorFromHex("00e300")),
                  MyAsset(size: 50, color: colorFromHex("e5d335")),
                  MyAsset(size: 50, color: colorFromHex("fe7c00")),
                  MyAsset(size: 50, color: colorFromHex("fe0000")),
                  MyAsset(size: 100, color: colorFromHex("98004b")),
                  MyAsset(size: 200, color: colorFromHex("7d0022")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Excellent',
                    style: _style2.copyWith(
                        color: Colors.grey.shade500, fontSize: 13),
                  ),
                  Text(
                    'Severe',
                    style: _style2.copyWith(
                        color: Colors.grey.shade500, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );

    //     Container(
    //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //       height: MediaQuery.of(context).size.height / 4,
    //       width: MediaQuery.of(context).size.width,
    //       child: Column(
    //         children: [
    //           Container(
    //             height: MediaQuery.of(context).size.height * 0.142,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(15),
    //               color: Colors.white,
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.withOpacity(0.4),
    //                   blurRadius: 15,
    //                   offset: Offset(6, 8),
    //                 ),
    //               ],
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 10),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         width: MediaQuery.of(context).size.width * 0.2,
    //                         child: Center(
    //                           child: Text('${wData.aqi}',
    //                               style: _style2.copyWith(
    //                                   fontSize: 40,
    //                                   color: AqiString.colorFromHexss(
    //                                       AqiString.getAqiColor(wData.aqi)))),
    //                         ),
    //                       ),
    //                       Container(
    //                         width: MediaQuery.of(context).size.width * 0.65,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               AqiString.getAqiLevel(wData.aqi),
    //                               style: _style1.copyWith(fontSize: 23),
    //                             ),
    //                             SizedBox(height: 5),
    //                             Text(AqiString.getAqiRecommend(wData.aqi),
    //                                 style: _style2.copyWith(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w500)),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   DetailProgressBar(
    //                     width: MediaQuery.of(context).size.width * 0.8,
    //                     height: 20,
    //                     radius: 0,
    //                     assetsLimit: 500,
    //                     assets: [
    //                       MyAssets(size: 50, num: 0),
    //                       MyAssets(size: 50, num: 50),
    //                       MyAssets(size: 50, num: 100),
    //                       MyAssets(size: 50, num: 150),
    //                       MyAssets(size: 100, num: 200),
    //                       MyAssets(size: 100, num: 300),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   MyAssetsBar(
    //                     width: MediaQuery.of(context).size.width * 0.8,
    //                     height: 5,
    //                     background: colorFromHex("CFD8DC"),
    //                     radius: 0,
    //                     assetsLimit: 500,
    //                     assets: [
    //                       MyAsset(size: 50, color: colorFromHex("00e300")),
    //                       MyAsset(size: 50, color: colorFromHex("fefe00")),
    //                       MyAsset(size: 50, color: colorFromHex("fe7c00")),
    //                       MyAsset(size: 50, color: colorFromHex("fe0000")),
    //                       MyAsset(size: 100, color: colorFromHex("98004b")),
    //                       MyAsset(size: 200, color: colorFromHex("7d0022")),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text('Excellent',
    //                             style: _style2.copyWith(fontSize: 12)),
    //                         Text(
    //                           'Severe',
    //                           style: _style2.copyWith(fontSize: 12),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 25, left: 20),
//             child: Text(
//               'Air Quality',
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   blurRadius: 15,
//                   offset: Offset(6, 8),
//                 ),
//               ],
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//             height: MediaQuery.of(context).size.height / 4,
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.1,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         child: Center(
//                           child: Text('20',
//                               style: _style2.copyWith(
//                                   fontSize: 40,
//                                   color: AqiString.colorFromHexss(
//                                       AqiString.getAqiColor(20)))),
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               AqiString.getAqiLevel(20),
//                               style: _style1,
//                             ),
//                             SizedBox(height: 5),
//                             Text(AqiString.getAqiRecommend(20),
//                                 style: _style2.copyWith(fontSize: 13)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DetailProgressBar(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: 20,
//                   radius: 0,
//                   assetsLimit: 500,
//                   assets: [
//                     MyAssets(size: 50, num: 0),
//                     MyAssets(size: 50, num: 50),
//                     MyAssets(size: 50, num: 100),
//                     MyAssets(size: 50, num: 150),
//                     MyAssets(size: 100, num: 200),
//                     MyAssets(size: 100, num: 300),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 MyAssetsBar(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: 10,
//                   background: colorFromHex("CFD8DC"),
//                   radius: 0,
//                   assetsLimit: 500,
//                   assets: [
//                     MyAsset(size: 50, color: colorFromHex("00e300")),
//                     MyAsset(size: 50, color: colorFromHex("fefe00")),
//                     MyAsset(size: 50, color: colorFromHex("fe7c00")),
//                     MyAsset(size: 50, color: colorFromHex("fe0000")),
//                     MyAsset(size: 100, color: colorFromHex("98004b")),
//                     MyAsset(size: 200, color: colorFromHex("7d0022")),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Excellent', style: _style2),
//                     Text(
//                       'Severe',
//                       style: _style2,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
