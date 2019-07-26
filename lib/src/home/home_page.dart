import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      print("Mudou pagina ${_pageController.page}");
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titlePages = [
      "Home",
      "Notificações",
      "Config",
    ];

    var animation2 = null;
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _pageController,
          builder: (BuildContext context, Widget child) {
            return Text(titlePages[_pageController.page.round()]);
          },
        ),
      ),
      body: buildBody(),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget child) {
          return BottomNavigationBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
            currentIndex: _pageController.page.round(),
            items: [
              BottomNavigationBarItem(
                title: Text('Home'),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Notificações'),
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                title: Text('Config'),
                icon: Icon(Icons.settings),
              ),
            ],
          );
        },
      ),
    );
  }

  buildBody() {
    return PageView.builder(
      itemCount: 3,
      controller: _pageController,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _homeArea();
            break;
          case 1:
            return _alertArea(_pageController);
            break;
          case 2:
            return _settingsArea();
            break;
        }
        return Container();
      },
    );
  }

  Widget _homeArea() {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.green,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _alertArea(PageController pageController) {
    return NotificationsPage(pageController);
  }

  Widget _settingsArea() {
    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  final PageController pageController;

  const NotificationsPage(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Notifications Screen',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 25.0,
            ),
          ),
          RaisedButton(child: Text('To Home'), onPressed: () {
            pageController.jumpToPage(0);
          },),
        ],
      ),
    );
  }
}
