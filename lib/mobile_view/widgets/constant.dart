import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VideoModel {
  final String profileURl;
  final String channelName;
  final String videoTitle;
  final String like;
  final String views;
  final String subscribers;
  final String time;
  final String videoThumbnail;
  RxBool subscribed;
  RxBool liked;

  VideoModel({
    required this.profileURl,
    required this.channelName,
    required this.videoTitle,
    required this.like,
    required this.views,
    required this.subscribers,
    required this.time,
    required this.videoThumbnail,
    bool subscribed = false,
    bool liked = false,
  })  : subscribed = subscribed.obs,
        liked = liked.obs;
}

List<VideoModel> videoinfo() {
  return [
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'keiani',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '2M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl: 'https://i.ytimg.com/vi/yMj7ENSlQtg/maxresdefault.jpg',
      channelName: 'ICC',
      videoTitle: 'Virat Kohli goes Out of the Ground | Ind vs Pak|',
      like: '1.1M',
      views: '21M',
      subscribers: '1.3M',
      time: '4 months ago',
      videoThumbnail:
          'https://greenwavegazette.org/wp-content/uploads/2019/01/Bird-Box-poster-horizontal.jpg',
    ),
    VideoModel(
      profileURl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRljPZAo_WetnC7v3HpCrABnNccHTCxb0ab_g&usqp=CAU',
      channelName: 'Netflix',
      videoTitle: 'Bird Box | Official Trailer |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://greenwavegazette.org/wp-content/uploads/2019/01/Bird-Box-poster-horizontal.jpg',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'raju',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'YT',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'OP',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'Dope',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'Raka',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'Aman',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'BornToKill',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'BornToSnipe',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
    VideoModel(
      profileURl:
          'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
      channelName: 'keiani',
      videoTitle: 'Crouching Lion | Hiking Vlog |',
      like: '521k',
      views: '21M',
      subscribers: '1.3M',
      time: '7 months ago',
      videoThumbnail:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
    ),
  ];
}

// List<VideoModel> suggestedVideoinfo() {
//   return [
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://cdn.theplaylist.net/wp-content/uploads/2021/12/14172154/annette-poster-691x1024.jpg',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//     VideoModel(
//       profileURl:
//           'https://i0.wp.com/dklassgh.net/wp-content/uploads/2024/02/Keiani-.jpg?resize=400%2C240&ssl=1',
//       channelName: 'keiani',
//       videoTitle: 'Crouching Lion | Hiking Vlog |',
//       like: '521k',
//       views: '21M',
//       subscribers: '1.3M',
//       time: '7 months ago',
//       videoThumbnail:
//           'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcitNNJtizi3m-u3z0jdfWnkTdMvgkOxG9jj5FQayjJEF956pgcQOLnOC9ksTXcbN7GHjjaJ7k8F5VhZL7oYgMlx9Dafe7588iEmzHIUne_gtcG68BIhSbT4nL6auntNeORxV4_9a5XOJIxf6AMDt5ZYVljZcHhe9Q9_gEp554ojw0t8YxFctxVCP2vUY/s1200/Explore%20Now%20%281%29%20%281%29.webp',
//     ),
//   ];
// }
