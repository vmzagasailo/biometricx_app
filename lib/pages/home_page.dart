import 'package:biometric_app/widgets/page_button.dart';
import 'package:biometric_app/widgets/product_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  var _scrollPosition = 0.0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildSliverAppBar(),
        _buildProductsList(),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    final deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: deviceSize.height * 0.2,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/iphone13.jpg',
          fit: BoxFit.fitWidth,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: _buildBottomAppBarButtons(),
      ),
    );
  }

  Widget _buildProductsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (_, index) => ProductItem(
                title: 'product title: #${index + 1}',
              ),
          childCount: 30),
    );
  }

  Widget _buildBottomAppBarButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            PageButton(
              title: 'First',
              onTap: _onFirstPageTap,
            ),
            (_scrollPosition < 790)
                ? _buildPageIndicator()
                : const SizedBox(height: 5),
          ],
        ),
        Column(
          children: [
            PageButton(
              title: 'Second',
              onTap: _onSecondPageTap,
            ),
            (_scrollPosition >= 790 && _scrollPosition < 1570)
                ? _buildPageIndicator()
                : const SizedBox(height: 5),
          ],
        ),
        Column(
          children: [
            PageButton(
              title: 'Third',
              onTap: _onThirdPageTap,
            ),
            (_scrollPosition >= 1570)
                ? _buildPageIndicator()
                : const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      height: 5,
      width: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  void _onFirstPageTap() {
    _scrollController.jumpTo(0);
  }

  void _onSecondPageTap() {
    _scrollController.jumpTo(790);
  }

  void _onThirdPageTap() {
    _scrollController.jumpTo(1570);
  }
}
