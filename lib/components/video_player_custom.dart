// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// // import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pod_player/pod_player.dart';
// // import 'package:pod_player/pod_player.dart';

// class VideoPlayerCustom extends StatefulWidget {
//   const VideoPlayerCustom({
//     super.key,
//     required this.item,
//     required this.action,
//     this.analyticsFunction,
//     this.showTitle = true,
//     this.fromZaker = false,
//     this.fromCourseVideo = false,
//   });
//   final String item;
//   final Function action;
//   final Function? analyticsFunction;
//   final bool fromCourseVideo;
//   final bool fromZaker;
//   final bool showTitle;
//   @override
//   State<VideoPlayerCustom> createState() => _VideoPlayerCustomState();
// }

// class _VideoPlayerCustomState extends State<VideoPlayerCustom>
//     with WidgetsBindingObserver {
//   // late PodPlayerController controller;
//   bool isLoop = false;

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (widget.analyticsFunction != null) {
//       widget.analyticsFunction!(controller, state);
//     }
//     super.didChangeAppLifecycleState(state);
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     if (widget.item.contains('mp4')) {
//       controller = PodPlayerController(
//           podPlayerConfig: PodPlayerConfig(

//               autoPlay: false,
//               forcedVideoFocus: false,
//               isLooping: false,
//               wakelockEnabled: true),
//           playVideoFrom: PlayVideoFrom.network(
//             widget.item,

//           ))
//         ..initialise();
//     } else {
//       controller = PodPlayerController(
//           podPlayerConfig: PodPlayerConfig(
//               autoPlay: false,
//               forcedVideoFocus: false,
//               isLooping: false,
//               wakelockEnabled: true),
//           playVideoFrom: PlayVideoFrom.vimeo(widget.item.split('/').last))
//         ..initialise();
//     }
//     widget.action(controller);
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(covariant VideoPlayerCustom oldWidget) {
//     if (widget.item != oldWidget.item) {
//       if (widget.item.contains('mp4')) {
//         controller.changeVideo(
//             playVideoFrom: PlayVideoFrom.network(widget.item));
//       } else {
//         controller.changeVideo(
//             playVideoFrom: PlayVideoFrom.vimeo(widget.item.split('/').last));
//       }
//       widget.action(controller);
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     if (widget.fromCourseVideo) {
//       // VideoController videoController = Get.put(VideoController());
//       // videoController.timer?.cancel();
//       // videoController.updateVideoViews(
//       //   watchTime: videoController.studentWatchTimeInSeconds.toString(),
//       //   id: videoController.id.toString(),
//       // );
//       // videoController.studentWatchTimeInSeconds = 0;
//     } else if (widget.fromZaker) {}
//     WidgetsBinding.instance.removeObserver(this);

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//           color: Colors.black, borderRadius: BorderRadius.circular(15.r)),
//       child: PodVideoPlayer(
//         frameAspectRatio: 2,
//         videoAspectRatio: 2,

//         matchVideoAspectRatioToFrame: true,
//         podProgressBarConfig: PodProgressBarConfig(),
//         onLoading: (context) {
//           return Center(
//               child: CupertinoActivityIndicator(
//             color: Colors.white,
//           ));
//         },
//         alwaysShowProgressBar: false,
//         // overlayBuilder: (OverLayOptions overlay) {
//         //   ////print(overlay.videoPlayBackSpeeds);
//         //
//         //   return Column(
//         //     children: [
//         //       SizedBox(
//         //         height: 20.h,
//         //       ),
//         //       Row(
//         //         children: [
//         //           GestureDetector(
//         //             onTap: () {
//         //               settings();
//         //             },
//         //             child: Icon(
//         //               Icons.more_vert,
//         //               color: Colors.white,
//         //             ),
//         //           ),
//         //           SizedBox(
//         //             width: 10.w,
//         //           )
//         //         ],
//         //       ),
//         //       SizedBox(height: 46.spMin),
//         //       Row(
//         //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //         children: [
//         //           GestureDetector(
//         //               onTap: () {
//         //                 controller
//         //                     .videoSeekBackward(Duration(seconds: 10));
//         //               },
//         //               child: SvgPicture.asset(
//         //                 getAppImage(imagePath: AppImages.forward_video),
//         //                 width: 28.spMin,
//         //               )),
//         //           GestureDetector(
//         //               onTap: () {
//         //                 controller.togglePlayPause();
//         //                 setState(() {});
//         //                 // if (controller.isVideoPlaying) {
//         //                 //   controller.pause();
//         //                 // } else {
//         //                 //   controller.play();
//         //                 // }
//         //               },
//         //               child: SvgPicture.asset(
//         //                 getAppImage(
//         //                     imagePath: controller.isVideoPlaying
//         //                         ? AppImages.pause
//         //                         : AppImages.play),
//         //                 width: 28.spMin,
//         //                 color: Colors.white,
//         //               )),
//         //           GestureDetector(
//         //               onTap: () {
//         //                 controller
//         //                     .videoSeekForward(Duration(seconds: 10));
//         //               },
//         //               child: SvgPicture.asset(
//         //                 getAppImage(imagePath: AppImages.backward_video),
//         //                 width: 28.spMin,
//         //               ))
//         //         ],
//         //       ),
//         //       Spacer(),
//         //       Row(
//         //         children: [
//         //           SizedBox(
//         //             width: 10.w,
//         //           ),
//         //           Text(
//         //             getVideoDuration(),
//         //             style: TextStyle(
//         //                 color: Colors.white,
//         //                 fontSize: 12.spMin,
//         //                 fontWeight: FontWeight.w600),
//         //           ),
//         //         ],
//         //       ),
//         //       SizedBox(
//         //         height: 6.h,
//         //       ),
//         //       Container(
//         //         height: 6.spMin,
//         //         child: LinearPercentIndicator(
//         //           lineHeight: 6.spMin,
//         //           percent: controller.currentVideoPosition.inSeconds /
//         //               controller.totalVideoLength.inSeconds,
//         //           backgroundColor: ColorManager.wightColor,
//         //           isRTL: true,
//         //           progressColor: ColorManager.textColorBlue,
//         //           barRadius: Radius.circular(15.r),
//         //         ),
//         //       ),
//         //       SizedBox(
//         //         height: 15.h,
//         //       )
//         //     ],
//         //   );
//         // },
//         controller: controller,
//       ),
//     );
//   }

//   settings(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15.r),
//                 topRight: Radius.circular(15.r))),
//         isScrollControlled: true,
//         builder: (context) {
//           return Container(
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(25.h),
//                     topLeft: Radius.circular(25.r))),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     isLoop = !isLoop;
//                     controller.setLooping(isLoop);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 45.h,
//                     color: Colors.transparent,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: .05.sw,
//                         ),
//                         Text(controller.value.isLooping ? 'مفعل' : 'مغلق'),
//                         SizedBox(
//                           width: 5.w,
//                         ),
//                         CircleAvatar(
//                           radius: 3,
//                           backgroundColor: isLoop
//                               ? AppColors.selectedfontColor
//                               : Colors.grey,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text('إعادة الفيديو'),
//                         Spacer(),
//                         Icon(Icons.refresh),
//                         SizedBox(
//                           width: .05.sw,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                     showPlayBackSpeed(context);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 45.h,
//                     color: Colors.transparent,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: .05.sw,
//                         ),
//                         Text(
//                           '${controller.value.playbackSpeed} x',
//                           textDirection: TextDirection.ltr,
//                         ),
//                         SizedBox(
//                           width: 5.w,
//                         ),
//                         CircleAvatar(
//                           radius: 3,
//                           backgroundColor: Colors.grey,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text('سرعة التشغيل'),
//                         Spacer(),
//                         Icon(Icons.speed),
//                         SizedBox(
//                           width: .05.sw,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   String getVideoDuration() {
//     int totalSeconds = controller.value.duration.inSeconds % 60;
//     int totalMin = controller.value.duration.inMinutes % 60;
//     int totalHour = controller.value.duration.inHours % 60;

//     String totalTime =
//         (totalSeconds > 9 ? totalSeconds.toString() : '0$totalSeconds');
//     if (totalMin > 0) {
//       totalTime = totalTime +
//           ' : ' +
//           (totalMin > 9 ? totalMin.toString() : '0$totalMin');
//     }
//     if (totalHour > 0) {
//       totalTime = totalTime +
//           ' : ' +
//           (totalHour > 9 ? totalHour.toString() : '0$totalHour');
//     }
//     int currentSeconds = controller.value.position.inSeconds % 60;
//     int currentMin = controller.value.position.inMinutes % 60;
//     int currentHour = controller.value.position.inHours % 60;

//     String currentTime =
//         (currentSeconds > 9 ? currentSeconds.toString() : '0$currentSeconds');
//     if (currentMin > 0) {
//       currentTime = currentTime +
//           ' : ' +
//           (currentMin > 9 ? currentMin.toString() : '0$currentMin');
//     }
//     if (currentHour > 0) {
//       currentTime = currentTime +
//           ' : ' +
//           (currentHour > 9 ? currentHour.toString() : '0$currentHour');
//     }

//     return totalTime.toString() + ' / ' + currentTime;
//   }

  // showPlayBackSpeed(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: ['.25', '.5', '.75', '1', '1.25', '1.5', '1.75', '2']
  //               .map((e) => GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);

  //                       controller.setPlaybackSpeed(double.parse(e));
  //                     },
  //                     child: Container(
  //                       width: double.infinity,
  //                       height: 45.h,
  //                       decoration: BoxDecoration(
  //                           border: Border(
  //                               bottom: BorderSide(
  //                         color: Colors.black38,
  //                         width: .5,
  //                       ))),
  //                       child: Center(
  //                         child: Text(
  //                           e,
  //                           textDirection: TextDirection.ltr,
  //                           locale: Locale('en'),
  //                         ),
  //                       ),
  //                     ),
  //                   ))
  //               .toList(),
  //         );
  //       });
  // }
// }
