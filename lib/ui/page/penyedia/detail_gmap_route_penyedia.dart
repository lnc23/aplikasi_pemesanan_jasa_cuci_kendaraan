// ignore_for_file: deprecated_member_use_from_same_package, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:lazywash/ui/page/widgets/here_map_route.dart';

class DetailGmapRoute extends StatefulWidget {
  DetailGmapRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailGmapRoute> createState() => _DetailGmapRouteState();
}

class _DetailGmapRouteState extends State<DetailGmapRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HereMapRoute(),
          SizedBox(
            height: 15,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailGmapRoute(),
                ),
              );
            },
            icon: new Image.asset('assets/ic_refresh.png'),
          ),
        ],
      ),
    );
  }
}
