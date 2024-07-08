import 'package:facebook_ui_resposive/screens/home_screen.dart';
import 'package:facebook_ui_resposive/widgets/custom_tab_bar.dart';
import 'package:facebook_ui_resposive/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../data/data.dart';
import '../widgets/custom_app_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
 final List<Widget> _screens = [
   const HomeScreen(),
   const Scaffold(),
   const Scaffold(),
   const Scaffold(),
   const Scaffold(),
   const Scaffold(),

 ];

 final List<IconData> _icons = [
   Icons.home,
   Icons.ondemand_video,
   MdiIcons.accountCircleOutline,
   MdiIcons.accountGroupOutline,
   MdiIcons.bellOutline,
   Icons.menu
 ];

 int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    // Hello There
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: _icons.length,
    child: Scaffold(
      appBar: Responsive.isDesktop(context) ? PreferredSize(
          preferredSize: Size(screenSize.width, 100.0),
          child: CustomAppBar(
            currentUser: currentUser,
            icon: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          )
      )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: !Responsive.isDesktop(context) ? Padding(
        padding: const EdgeInsets.only(bottom:6.0),
        child: CustomTabBar(
          icons: _icons,
          selectedIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ) : const SizedBox.shrink(),
    ));
  }
}
