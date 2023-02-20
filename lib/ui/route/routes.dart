import 'package:fitness/ui/views/auth/forgot_password.dart';
import 'package:fitness/ui/views/auth/login.dart';
import 'package:fitness/ui/views/auth/registration.dart';
import 'package:fitness/ui/views/home/bottom_nav_controller.dart';
import 'package:fitness/ui/views/onboarding/onboarding_screen.dart';
import 'package:fitness/ui/views/splash/splash.dart';
import 'package:get/get.dart';

import '../views/home/media/categories/blog_categories.dart';
import '../views/home/media/categories/podcast_categories.dart';
import '../views/home/media/categories/video_categories.dart';

const String splash = '/splash';
const String onboarding = '/onbording';
const String login = '/login';
const String registration = '/registration';
const String forgotPassword = '/forgotPassword';
const String bottomNavController = '/bottomNavController';
const String blogCategories = '/blogcategories';
const String podcastCategories = '/podcastCategories';
const String videoCategories = '/videoCategories';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => Splash(),
  ),
  GetPage(
    name: onboarding,
    page: () => OnboardingScreen(),
  ),
  GetPage(
    name: login,
    page: () => Login(),
  ),
  GetPage(
    name: registration,
    page: () => Registration(),
  ),
  GetPage(
    name: forgotPassword,
    page: () => ForgotPassword(),
  ),
   GetPage(
    name: bottomNavController,
    page: () => BottomNavController(),
  ),
    GetPage(
    name: blogCategories,
    page: () {
      BlogCategories _blogcategories = Get.arguments;
      return _blogcategories;
    },
  ),
    GetPage(
    name: podcastCategories,
    page: () {
      PodcastCategories _podcastDetailsSCreen = Get.arguments;
      return _podcastDetailsSCreen;
    },
  ),
   GetPage(
    name: videoCategories,
    page: () {
      VideoCategories _videoDetailsSCreen = Get.arguments;
      return _videoDetailsSCreen;
    },
  ),
];


