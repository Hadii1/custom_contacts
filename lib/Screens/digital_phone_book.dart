import 'package:custom_contacts_prototype/Data/contact.dart';
import 'package:custom_contacts_prototype/Data/dummy_data.dart';
import 'package:custom_contacts_prototype/Screens/contact_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> _alphabetList = [
  '#',
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
];

class DigitalPhoneBookScreen extends StatefulWidget {
  @override
  _DigitalPhoneBookScreenState createState() => _DigitalPhoneBookScreenState();
}

class _DigitalPhoneBookScreenState extends State<DigitalPhoneBookScreen> {
  List<Contact> _dummyContacts = DummyData.getDummyContents();

  void _filterList(String job) {
    setState(() {
      if (job == '') {
        _dummyContacts = DummyData.getDummyContents();
      } else {
        _dummyContacts = DummyData.getDummyContents()
          ..removeWhere((element) => element.jobTitle != job);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.maxFinite,
            child: Material(
              color: Colors.grey[100],
              elevation: 0.5,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          'All Contancts',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 19,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            child: Icon(
                              Icons.receipt,
                              color: Colors.black87,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: SearchBar(),
                    ),
                    Expanded(
                      child: FilterGrid(
                        onFilterChanged: (jobType) {
                          setState(() {
                            _filterList(jobType);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: NativeListView(allContacts: _dummyContacts)),
        ],
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({@required this.contact});
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: SlidePanel(
        onChildPressed: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => ContactDetails(contact: contact),
          ),
        ),
        menuItems: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              bool launchable = await canLaunch(
                'tel:${contact.phoneNumber}',
              );

              if (launchable) {
                launch(
                  'tel:${contact.phoneNumber}',
                );
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Couldn\'t Launch Call'),
                  ),
                );
              }
            },
            child: Icon(
              FontAwesome.phone_square,
              color: Colors.blue,
              size: 21,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: Icon(
                Icons.sms,
                color: Colors.blue,
                size: 21,
              ),
            ),
          )
        ],
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Center(
            child: Container(
              width: double.maxFinite,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: contact.firstName,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: ' ${contact.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 24, right: 24),
      child: SizedBox(
        height: 45,
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic),
            labelText: 'Search',
            labelStyle: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

class FilterGrid extends StatefulWidget {
  const FilterGrid({@required this.onFilterChanged});
  final Function(String) onFilterChanged;

  @override
  _FilterGridState createState() => _FilterGridState();
}

class _FilterGridState extends State<FilterGrid> {
  String _selectedFilter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildFilterChips('Duty Officer'),
              _buildFilterChips('Sales Man'),
              _buildFilterChips('Marines'),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildFilterChips('Mathmatician'),
              _buildFilterChips('Developer'),
              _buildFilterChips('Electrician'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(String label) {
    return ChoiceChip(
      backgroundColor: Colors.grey.withAlpha(325),
      label: Text(label),
      selected: label == _selectedFilter,
      onSelected: (selected) {
        setState(
          () {
            if (selected) {
              _selectedFilter = label;
            } else {
              _selectedFilter = '';
            }
          },
        );
        widget.onFilterChanged(_selectedFilter);
      },
    );
  }
}

class NativeListView extends StatefulWidget {
  const NativeListView({@required this.allContacts});
  final List<Contact> allContacts;
  @override
  _NativeListViewState createState() => _NativeListViewState();
}

class _NativeListViewState extends State<NativeListView> {
  ScrollController _scrollController = ScrollController();
  bool _shouldShowHeader = true;
  String _latestLetter;
  double _maxScrollExtent;

  List<Contact> get contacts => widget.allContacts
    ..sort((a, b) {
      return a.firstName
          .substring(0, 1)
          .toLowerCase()
          .compareTo(b.firstName.substring(0, 1).toLowerCase());
    });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _maxScrollExtent = _scrollController.position.maxScrollExtent;
    });

    _scrollController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          padding: const EdgeInsets.only(bottom: 8),
          itemCount: contacts.length,
          controller: _scrollController,
          itemBuilder: (_, index) {
            var currentLetter =
                contacts[index].firstName.substring(0, 1).toLowerCase();
            if (index == 0) {
              _shouldShowHeader = true;
              _latestLetter = currentLetter;
            } else {
              if (currentLetter != _latestLetter) {
                _shouldShowHeader = true;
                _latestLetter = currentLetter;
              } else {
                _shouldShowHeader = false;
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _shouldShowHeader
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 18,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              currentLetter.toUpperCase(),
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                ContactTile(
                  contact: contacts[index],
                ),
                index != contacts.length - 1 &&
                        currentLetter ==
                            contacts[index + 1]
                                .firstName
                                .substring(0, 1)
                                .toLowerCase()
                    ? Divider()
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
        // Container(
        //   width: double.maxFinite,
        //   height: 18,
        //   color: Colors.grey[200],
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 12.0),
        //     child: Text(
        //       'asd',
        //       style: TextStyle(color: Colors.blue),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.centerRight,
          child: AlphabetScrollBar(
            height: 400,
            onLetterChange: (index) {
              _jumpToLetter(index);
            },
          ),
        ),
      ],
    );
  }

  void _jumpToLetter(int index) {
    int i;

    //if the letter pressed wasn't found we search for the letter before (likewise in native iOS)
    do {
      i = contacts.indexWhere(
        (element) =>
            element.firstName.substring(0, 1).toLowerCase() ==
            _alphabetList[index].toLowerCase(),
      );

      if (index == 0) {
        break;
      }

      index--;
    } while (i == -1);

    double offset = _maxScrollExtent * (i / contacts.length) + (index - 1) * 15;

    if (offset > _scrollController.position.maxScrollExtent) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else if (offset < _scrollController.position.minScrollExtent) {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    } else {
      _scrollController.jumpTo(offset);
    }
  }
}

class AlphabetScrollBar extends StatelessWidget {
  const AlphabetScrollBar({
    @required this.onLetterChange,
    this.height,
  });

  final double height;
  final Function(int) onLetterChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 15,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanDown: (d) {

          onLetterChange(_calculateIndex(d.localPosition.dy));
        },
        onPanStart: (d) {

          onLetterChange(_calculateIndex(d.localPosition.dy));
        },
        onPanUpdate: (d) {
          HapticFeedback.lightImpact();
          onLetterChange(_calculateIndex(d.localPosition.dy));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _alphabetList
              .map((letter) => SizedBox(
                    height: height / 27,
                    child: Center(
                      child: Text(
                        letter.toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  int _calculateIndex(double position) {
    int index = (position / (height / 26)).round();
    if (index < 0) {
      return 0;
    } else if (index > 26) {
      return 26;
    } else {
      return index;
    }
  }
}

class SlidePanel extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;
  final Function() onChildPressed;

  SlidePanel({
    @required this.child,
    @required this.menuItems,
    @required this.onChildPressed,
  });

  @override
  _SlidePanelState createState() => _SlidePanelState();
}

class _SlidePanelState extends State<SlidePanel>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.25, 0.0))
            .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          _controller.value -= data.primaryDelta / context.size.width;
        });
      },
      onTap: () => widget.onChildPressed(),
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity > 1000) {
          _controller.animateTo(0); //fully close on fast swipe left
        } else if (data.primaryVelocity < -1000) {
          _controller.animateTo(1); //fully open on fast swipe right
        } else if (data.primaryVelocity > 0 && _controller.value < 0.7) {
          _controller.animateTo(0);
        } else {
          _controller.animateTo(0);
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: animation,
            child: widget.child,
          ),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: widget.menuItems.map((child) {
                                return Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
