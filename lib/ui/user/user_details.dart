import 'package:flutter/material.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';
import 'package:pettygram_flutter/widgets/grid_posts.dart';
import 'package:pettygram_flutter/widgets/info_box.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username!),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {},
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleImage(imageUrl: user.imageUrl!),
                              const SizedBox(
                                height: 12,
                              ),
                              Text("${user.firstName} ${user.lastName}")
                            ],
                          ),
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const InfoBox(label: 'Posts', info: 0),
                                const SizedBox(
                                  width: 25,
                                ),
                                InfoBox(
                                    label: 'Followers',
                                    info: user.followers?.length ?? 0),
                                const SizedBox(
                                  width: 25,
                                ),
                                InfoBox(
                                    label: 'Following',
                                    info: user.following?.length ?? 0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.elliptical(10, 10),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 14,
                          ),
                          const Icon(Icons.explore_rounded)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: const Column(
            children: [
              TabBar(
                labelPadding: EdgeInsets.only(bottom: 16, top: 12),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [Icon(Icons.grid_on), Icon(Icons.save)],
              ),
              Expanded(
                child: TabBarView(
                  children: [GridPosts(), Text('Save your first post')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
