
import 'package:facebook_ui_resposive/widgets/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/palette.dart';
import '../data/data.dart';
import '../models/post_model.dart';
import '../widgets/circle_button.dart';
import '../widgets/contacts_list.dart';
import '../widgets/create_post_container.dart';
import '../widgets/more_option_list.dart';
import '../widgets/post_container.dart';
import '../widgets/rooms.dart';
import '../widgets/stories.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:  Scaffold(
        body: Responsive(

          mobile: _HomeScreenMobile(scrollController: _trackingScrollController),
          desktop: _HomeScreenDesktop(scrollController: _trackingScrollController),
          tablet: _HomeScreenMobile(scrollController: _trackingScrollController) ,

        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  const _HomeScreenMobile({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          title: const Text('facebook',style: TextStyle(
            color: Palette.facebookBlue,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
                icon: Icons.search,
                iconSize: 30.0,
                onPressed: (){
                  if (kDebugMode) {
                    print('Search');
                  }
                }),
            CircleButton(
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: (){
                  if (kDebugMode) {
                    print('Messenger');
                  }
                } )
          ],
        ),
        const SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser,),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(
                currentUser: currentUser,
                stories: stories
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((ctx,index){
            final Post post = posts[index];
            return PostContainer(post: post);
          },
            childCount: posts.length,
          ),

        )
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
 final TrackingScrollController scrollController;
  const _HomeScreenDesktop({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MoreOptionList(currentUser: currentUser),
              ),
            )
        ),
        const Spacer(),

        Container(
          width: 550.0,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                      currentUser: currentUser,
                      stories: stories
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: CreatePostContainer(currentUser: currentUser,),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate((ctx,index){
                  final Post post = posts[index];
                  return PostContainer(post: post);
                },
                  childCount: posts.length,
                ),

              )
            ],
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ContactsList(users: onlineUsers),
            ),
          )
        ),
      ],
    );
  }
}
