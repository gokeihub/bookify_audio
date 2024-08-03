// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       home: AudioPlayerScreen(),
//     ),
//   );
// }

// class AudioPlayerScreen extends StatefulWidget {
//   const AudioPlayerScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }

// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late YoutubePlayerController _controller;
//   double _currentSliderValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: 'WRHz0g-GMVA', // Your video ID
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//         hideControls: true,
//       ),
//     );
//     _controller.addListener(_listener);
//   }

//   void _listener() {
//     if (_controller.value.isReady && !_controller.value.isFullScreen) {
//       setState(() {
//         _currentSliderValue = _controller.value.position.inSeconds.toDouble();
//       });
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Audio Player')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Now playing: YouTube Audio'),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   _formatDuration(
//                     Duration(
//                       seconds: _currentSliderValue.toInt(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Slider(
//                     value: _currentSliderValue,
//                     min: 0,
//                     max: _controller.metadata.duration.inSeconds.toDouble(),
//                     onChanged: (double value) {
//                       setState(() {
//                         _currentSliderValue = value;
//                       });
//                       _controller.seekTo(Duration(seconds: value.toInt()));
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(_formatDuration(_controller.metadata.duration)),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   if (_controller.value.isPlaying) {
//                     _controller.pause();
//                   } else {
//                     _controller.play();
//                   }
//                 });
//               },
//               child: Icon(
//                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//               ),
//             ),
//             Opacity(
//               opacity: 0,
//               child: SizedBox(
//                 height: 0,
//                 width: 0,
//                 child: YoutubePlayer(controller: _controller),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_listener);
//     _controller.dispose();
//     super.dispose();
//   }
// }




 






// Not Change This File Code

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       home: AudioPlayerScreen(),
//     ),
//   );
// }

// class AudioPlayerScreen extends StatefulWidget {
//   const AudioPlayerScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }

// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late YoutubePlayerController _controller;
//   double _currentSliderValue = 0;
//   double _playbackSpeed = 1.0; // Default playback speed

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: '4hKy3-MRs_s', // Your video ID
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         hideControls: true,
//         forceHD: false,
//         enableCaption: false,
//         hideThumbnail: true,
//       ),
//     );
//     _controller.addListener(_listener);
//   }

//   void _listener() {
//     if (_controller.value.isReady && !_controller.value.isFullScreen) {
//       setState(() {
//         _currentSliderValue = _controller.value.position.inSeconds.toDouble();
//       });
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }

//   void _setPlaybackSpeed(double speed) {
//     setState(() {
//       _playbackSpeed = speed;
//     });
//     _controller.setPlaybackRate(speed);
//   }

//   void _undo() {
//     double newPosition = _currentSliderValue - 10;
//     if (newPosition < 0) newPosition = 0;
//     _controller.seekTo(Duration(seconds: newPosition.toInt()));
//   }

//   void _redo() {
//     double newPosition = _currentSliderValue + 10;
//     if (newPosition > _controller.metadata.duration.inSeconds.toDouble()) {
//       newPosition = _controller.metadata.duration.inSeconds.toDouble();
//     }
//     _controller.seekTo(Duration(seconds: newPosition.toInt()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Subha')),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CachedNetworkImage(
//               imageUrl: "https://i.postimg.cc/T1YbvZjk/suva.jpg",
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               height: 200,
//               width: 330,
//               fit: BoxFit.fill,
//             ),
//             const Text('সুভা'),
//             const SizedBox(height: 10),
//             const Text('রবীন্দ্রনাথ ঠাকুর'),
//             const SizedBox(width: 10),
//             Slider(
//               value: _currentSliderValue,
//               min: 0,
//               max: _controller.metadata.duration.inSeconds.toDouble(),
//               onChanged: (double value) {
//                 setState(() {
//                   _currentSliderValue = value;
//                 });
//                 _controller.seekTo(Duration(seconds: value.toInt()));
//               },
//             ),
//             const SizedBox(width: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   _formatDuration(
//                     Duration(
//                       seconds: _currentSliderValue.toInt(),
//                     ),
//                   ),
//                 ),
//                 Text(_formatDuration(_controller.metadata.duration)),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   DropdownButton<double>(
//                     value: _playbackSpeed,
//                     items: const [
//                       DropdownMenuItem(value: 0.25, child: Text('0.25x')),
//                       DropdownMenuItem(value: 0.5, child: Text('0.5x')),
//                       DropdownMenuItem(value: 1.0, child: Text('1.0x')),
//                       DropdownMenuItem(value: 1.25, child: Text('1.25x')),
//                       DropdownMenuItem(value: 1.5, child: Text('1.5x')),
//                       DropdownMenuItem(value: 1.75, child: Text('1.75x')),
//                       DropdownMenuItem(value: 2.0, child: Text('2.0x')),
//                       DropdownMenuItem(value: 2.5, child: Text('2.5x')),
//                       DropdownMenuItem(value: 3.0, child: Text('3.0x')),
//                       DropdownMenuItem(value: 3.5, child: Text('3.5x')),
//                       DropdownMenuItem(value: 4.0, child: Text('4.0x')),
//                     ],
//                     onChanged: (double? newValue) {
//                       if (newValue != null) {
//                         _setPlaybackSpeed(newValue);
//                       }
//                     },
//                     hint: const Text('Playback Speed'),
//                   ),
//                   const SizedBox(width: 10),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         if (_controller.value.isPlaying) {
//                           _controller.pause();
//                         } else {
//                           _controller.play();
//                         }
//                       });
//                     },
//                     icon: Icon(
//                       _controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: _undo,
//                     icon: const Icon(Icons.replay_10),
//                   ),
//                   IconButton(
//                     onPressed: _redo,
//                     icon: const Icon(Icons.forward_10),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Opacity(
//               opacity: 0,
//               child: SizedBox(
//                 height: 0,
//                 width: 0,
//                 child: YoutubePlayer(controller: _controller),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_listener);
//     _controller.dispose();
//     super.dispose();
//   }
// }