import 'dart:io';
import 'package:foap/helper/imports/common_import.dart';
import 'package:foap/screens/chat/chat_history.dart';
import 'package:foap/screens/content_creator_view.dart';
import 'package:foap/screens/settings_menu/packages_screen.dart';
import '../../components/force_update_view.dart';
import '../../main.dart';
import '../add_on/ui/reel/reels.dart';
import '../home_feed/home_feed_screen.dart';
import '../profile/my_profile.dart';
import '../settings_menu/settings_controller.dart';
import 'explore.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt unreadMsgCount = 0.obs;
  RxBool isLoading = false.obs;

  indexChanged(int index) {
    currentIndex.value = index;
  }

  updateUnreadMessageCount(int count) {
    unreadMsgCount.value = count;
  }
}

class DashboardScreen extends StatefulWidget {
  bool isHomeView;
  DashboardScreen({this.isHomeView = false, Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<DashboardScreen> {
  final DashboardController _dashboardController = Get.find();
  final SettingsController _settingsController = Get.find();

  List<Widget> widgets = [];
  bool hasPermission = false;

  @override
  void initState() {
    isAnyPageInStack = true;

    widgets = [
      ChatHistory(isDashboard: true),
      // const HomeFeedScreen(),

      // const Explore(),
      const Reels(
        needBackBtn: false,
      ),
      ContentCreatorView(isComingFromDashboard: true),

      PackagesScreen(isComingFromDashboard: true),
      // const WatchVideos(),
      const MyProfile(
        showBack: false,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _dashboardController.isLoading.value == true
        ? SizedBox(
            height: Get.height,
            width: Get.width,
            child: const Center(child: CircularProgressIndicator()),
          )
        : _settingsController.forceUpdate.value == true
            ? ForceUpdateView()
            : _settingsController.appearanceChanged?.value == null
                ? Container()
                : AppScaffold(
                    backgroundColor: AppColorConstants.backgroundColor,
                    // body:  widgets[_dashboardController.currentIndex.value],

                    body: widget.isHomeView
                        ? [
                            const HomeFeedScreen(),

                            // const Explore(),
                            const Reels(
                              needBackBtn: false,
                            ),
                            ContentCreatorView(isComingFromDashboard: true),

                            PackagesScreen(isComingFromDashboard: true),
                            // const WatchVideos(),
                            const MyProfile(
                              showBack: false,
                            ),
                          ][_dashboardController.currentIndex.value]
                        : [
                            ChatHistory(isDashboard: true),
                            // const HomeFeedScreen(),

                            // const Explore(),
                            const Reels(
                              needBackBtn: false,
                            ),
                            ContentCreatorView(isComingFromDashboard: true),

                            PackagesScreen(isComingFromDashboard: true),
                            // const WatchVideos(),
                            const MyProfile(
                              showBack: false,
                            ),
                          ][_dashboardController.currentIndex.value],

                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    // bottomNavigationBar: SizedBox(
                    //   height: Platform.isIOS ? 100 : 80,
                    //   width: Get.width,
                    //   child: BottomBarCreative(
                    //     iconSize: 25,
                    //     isFloating: false,

                    //     items: items,
                    //     backgroundColor: AppColorConstants.cardColor,
                    //     color: AppColorConstants.iconColor,
                    //     colorSelected: AppColorConstants.themeColor,
                    //     indexSelected: _dashboardController.currentIndex.value,
                    //     // highlightStyle: const HighlightStyle(
                    //     //     sizeLarge: true,
                    //     //     background: Colors.red,
                    //     //     elevation: 3),
                    //     // isFloating: true,
                    //     onTap: (index) {
                    //       _dashboardController.indexChanged(index);
                    //     },
                    //     // backgroundSelected: AppColorConstants.themeColor,
                    //   ),
                    // ),
                    // floatingActionButton: Container(
                    //   padding: EdgeInsets.all(15),
                    //   height: 50,
                    //   width: 50,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle, color: Colors.white),
                    //   child: Image.asset(
                    //     "assets/Icons/add_post.png",
                    //     height: 20,
                    //   ),
                    // ),
                    bottomNavigationBar: SizedBox(
                      height: Platform.isIOS ? 100 : 80,
                      width: Get.width,
                      child: BottomNavigationBar(
                        iconSize: 25,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle:
                            TextStyle(color: AppColorConstants.red),
                        selectedItemColor: AppColorConstants.red,
                        selectedIconTheme:
                            IconThemeData(color: AppColorConstants.red),

                        items: [
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/Icons/Chat.png',
                              height: 20,
                              color: checkCurrentIndex(0)
                                  ? AppColorConstants.red
                                  : Colors.black,
                            ),
                            label: 'Chat',
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/Icons/Reels.webp',
                              height: 20,
                              color: checkCurrentIndex(1)
                                  ? AppColorConstants.red
                                  : Colors.black,
                            ),
                            label: 'Reels',
                          ),
                          BottomNavigationBarItem(
                            icon: Container(
                              padding: EdgeInsets.all(12),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Image.asset(
                                "assets/Icons/add_post.png",
                                height: 20,
                                color: checkCurrentIndex(2)
                                    ? AppColorConstants.red
                                    : Colors.black,
                              ),
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/Icons/Premium.png',
                              height: 20,
                              color: checkCurrentIndex(3)
                                  ? AppColorConstants.red
                                  : Colors.black,
                            ),
                            label: 'Coin',
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/Icons/Profile.png',
                              height: 20,
                              color: checkCurrentIndex(4)
                                  ? AppColorConstants.red
                                  : Colors.black,
                            ),
                            label: 'Profile',
                          ),
                        ],
                        backgroundColor: AppColorConstants.cardColor,
                        // color: AppColorConstants.iconColor,
                        // colorSelected: AppColorConstants.themeColor,
                        currentIndex: _dashboardController.currentIndex.value,
                        // highlightStyle: const HighlightStyle(
                        //     sizeLarge: true,
                        //     background: Colors.red,
                        //     elevation: 3),
                        // isFloating: true,
                        onTap: (index) {
                          _dashboardController.indexChanged(index);
                        },
                        // backgroundSelected: AppColorConstants.themeColor,
                      ),
                    ),
                  ));
  }

  bool checkCurrentIndex(int index) {
    return _dashboardController.currentIndex.value == index;
  }

  void onTabTapped(int index) async {
    // if (index == 2) {
    //   Future.delayed(
    //     Duration.zero,
    //     () => showGeneralDialog(
    //         context: context,
    //         pageBuilder: (context, animation, secondaryAnimation) =>
    //             const AddPostScreen(
    //               postType: PostType.basic,
    //             )),
    //   );
    // } else {
    Future.delayed(
        Duration.zero, () => _dashboardController.indexChanged(index));
    // }
  }
}
