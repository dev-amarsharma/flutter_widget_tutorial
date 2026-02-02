import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetCatalogPage extends StatefulWidget {
  final Set<String> readAssets;
  final void Function(String assetPath) onOpenWidget;
  final VoidCallback onClear;

  const WidgetCatalogPage({
    Key? key,
    required this.readAssets,
    required this.onOpenWidget,
    required this.onClear,
  }) : super(key: key);

  @override
  State<WidgetCatalogPage> createState() => _WidgetCatalogPageState();

  // Catalog data: category, list of (display name, asset path)
  static const List<Map<String, dynamic>> catalog = [
    {
      'category': 'Basic Widgets',
      'widgets': [
        {'name': 'Text', 'asset': 'assets/textview.md'},
        {'name': 'Icon', 'asset': 'assets/icon.md'},
        {'name': 'Image', 'asset': 'assets/image.md'},
        {'name': 'Placeholder', 'asset': 'assets/placeholder.md'},
        {'name': 'Rich Text', 'asset': 'assets/richtext.md'},
      ],
    },
    {
      'category': 'Container & Box Widgets',
      'widgets': [
        {'name': 'Container', 'asset': 'assets/container.md'},
        {'name': 'Card', 'asset': 'assets/card.md'},
        {'name': 'Sized Box', 'asset': 'assets/sizedbox.md'},
        {'name': 'Decorated Box', 'asset': 'assets/decoratedbox.md'},
        {'name': 'Divider', 'asset': 'assets/divider.md'},
      ],
    },
    {
      'category': 'Layout Widgets',
      'widgets': [
        {'name': 'Row', 'asset': 'assets/row.md'},
        {'name': 'Column', 'asset': 'assets/column.md'},
        {'name': 'Stack', 'asset': 'assets/stack.md'},
        {'name': 'Wrap', 'asset': 'assets/wrap.md'},
        {'name': 'Table', 'asset': 'assets/table.md'},
      ],
    },
    {
      'category': 'Scrollable Widgets',
      'widgets': [
        {'name': 'List View', 'asset': 'assets/listview.md'},
        {'name': 'Grid View', 'asset': 'assets/gridview.md'},
        {'name': 'Page View', 'asset': 'assets/pageview.md'},
        {
          'name': 'Single Child Scroll View',
          'asset': 'assets/singlechildscrollview.md',
        },
        {'name': 'Scrollbar', 'asset': 'assets/scrollbar.md'},
      ],
    },
    {
      'category': 'Styling & Theming',
      'widgets': [
        {'name': 'Theme', 'asset': 'assets/theme.md'},
        {'name': 'ThemeData', 'asset': 'assets/themedata.md'},
        {'name': 'Opacity', 'asset': 'assets/opacity.md'},
        {'name': 'Color Filtered', 'asset': 'assets/colorfiltered.md'},
        {'name': 'Default Text Style', 'asset': 'assets/defaulttextstyle.md'},
      ],
    },
    {
      'category': 'Buttons',
      'widgets': [
        {'name': 'Elevated Button', 'asset': 'assets/elevatedbutton.md'},
        {'name': 'Text Button', 'asset': 'assets/textbutton.md'},
        {'name': 'Outlined Button', 'asset': 'assets/outlinedbutton.md'},
        {'name': 'Icon Button', 'asset': 'assets/iconbutton.md'},
        {
          'name': 'Floating Action Button',
          'asset': 'assets/floatingactionbutton.md',
        },
      ],
    },
    {
      'category': 'App Structure',
      'widgets': [
        {'name': 'Scaffold', 'asset': 'assets/scaffold.md'},
        {'name': 'App Bar', 'asset': 'assets/appbar.md'},
        {'name': 'Drawer', 'asset': 'assets/drawer.md'},
        {
          'name': 'Bottom Navigation Bar',
          'asset': 'assets/bottomnavigationbar.md',
        },
        {'name': 'Tab Bar', 'asset': 'assets/tabbar.md'},
      ],
    },
    {
      'category': 'Input & Forms',
      'widgets': [
        {'name': 'Text Field', 'asset': 'assets/textfield.md'},
        {'name': 'Text Form Field', 'asset': 'assets/textformfield.md'},
        {'name': 'Form', 'asset': 'assets/form.md'},
        {'name': 'Checkbox', 'asset': 'assets/checkbox.md'},
        {'name': 'Radio', 'asset': 'assets/radio.md'},
        {'name': 'Switch', 'asset': 'assets/switch.md'},
        {'name': 'Slider', 'asset': 'assets/slider.md'},
        {'name': 'Dropdown Button', 'asset': 'assets/dropdownbutton.md'},
        {'name': 'Date Picker', 'asset': 'assets/datepicker.md'},
        {'name': 'Time Picker', 'asset': 'assets/timepicker.md'},
      ],
    },
    {
      'category': 'Dialogs & Overlays',
      'widgets': [
        {'name': 'Alert Dialog', 'asset': 'assets/alertdialog.md'},
        {'name': 'Simple Dialog', 'asset': 'assets/simpledialog.md'},
        {'name': 'Dialog', 'asset': 'assets/dialog.md'},
        {'name': 'Bottom Sheet', 'asset': 'assets/bottomsheet.md'},
        {'name': 'Snack Bar', 'asset': 'assets/snackbar.md'},
        {'name': 'Tooltip', 'asset': 'assets/tooltip.md'},
        {'name': 'Popup Menu Button', 'asset': 'assets/popupmenubutton.md'},
      ],
    },
    {
      'category': 'Navigation',
      'widgets': [
        {'name': 'Navigator', 'asset': 'assets/navigator.md'},
        {'name': 'Material Page Route', 'asset': 'assets/materialpageroute.md'},
        {'name': 'Page Route Builder', 'asset': 'assets/pageroutebuilder.md'},
        {'name': 'Hero', 'asset': 'assets/hero.md'},
        {'name': 'Routes', 'asset': 'assets/routes.md'},
      ],
    },
    {
      'category': 'Animations',
      'widgets': [
        {'name': 'Animated Container', 'asset': 'assets/animatedcontainer.md'},
        {'name': 'Animated Opacity', 'asset': 'assets/animatedopacity.md'},
        {'name': 'Animated Align', 'asset': 'assets/animatedalign.md'},
        {
          'name': 'Animated Positioned',
          'asset': 'assets/animatedpositioned.md',
        },
        {
          'name': 'Tween Animation Builder',
          'asset': 'assets/tweenanimationbuilder.md',
        },
        {'name': 'Animated Builder', 'asset': 'assets/animatedbuilder.md'},
        {'name': 'Fade Transition', 'asset': 'assets/fadetransition.md'},
        {'name': 'Scale Transition', 'asset': 'assets/scaletransition.md'},
      ],
    },
    {
      'category': 'Cupertino (iOS)',
      'widgets': [
        {'name': 'Cupertino App', 'asset': 'assets/cupertinoapp.md'},
        {'name': 'Cupertino Button', 'asset': 'assets/cupertinobutton.md'},
        {'name': 'Cupertino Switch', 'asset': 'assets/cupertinoswitch.md'},
        {
          'name': 'Cupertino Navigation Bar',
          'asset': 'assets/cupertinonavigationbar.md',
        },
        {'name': 'Cupertino Tab Bar', 'asset': 'assets/cupertinotabbar.md'},
        {
          'name': 'Cupertino Page Scaffold',
          'asset': 'assets/cupertinopagescaffold.md',
        },
      ],
    },
    {
      'category': 'Custom/Advanced',
      'widgets': [
        {'name': 'Custom Paint', 'asset': 'assets/custompaint.md'},
        {'name': 'Custom Scroll View', 'asset': 'assets/customscrollview.md'},
        {'name': 'Sliver List', 'asset': 'assets/sliverlist.md'},
        {'name': 'Sliver Grid', 'asset': 'assets/slivergrid.md'},
        {'name': 'Layout Builder', 'asset': 'assets/layoutbuilder.md'},
        {'name': 'Builder', 'asset': 'assets/builder.md'},
        {'name': 'Gesture Detector', 'asset': 'assets/gesturedetector.md'},
        {'name': 'Repaint Boundary', 'asset': 'assets/repaintboundary.md'},
      ],
    },
  ];
}

class _WidgetCatalogPageState extends State<WidgetCatalogPage> {
  late ScrollController _scrollController;
  Timer? _saveTimer;
  static const _prefsScrollKey = 'catalog_scroll_offset';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadScrollOffset();
  }

  void _onScroll() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 400), () {
      _saveScrollOffset();
    });
  }

  Future<void> _loadScrollOffset() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final double? offset = prefs.getDouble(_prefsScrollKey);
      if (offset != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            final max = _scrollController.position.maxScrollExtent;
            final pos = offset.clamp(0.0, max);
            _scrollController.jumpTo(pos);
          }
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading scroll offset: $e');
    }
  }

  Future<void> _saveScrollOffset() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_prefsScrollKey, _scrollController.offset);
    } catch (e) {
      // ignore: avoid_print
      print('Error saving scroll offset: $e');
    }
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _saveScrollOffset();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,
          backgroundColor: Colors.deepOrange[400],
          actions: [
            IconButton(
              tooltip: 'Clear read history',
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Clear read history?'),
                        content: const Text(
                          'This will clear saved "read" marks and scroll position.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                );
                if (confirm == true) {
                  widget.onClear();
                }
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            title: Text(
              'Flutter Widgets Catalog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange[400]!.withOpacity(0.85),
                        Colors.orange[200]!.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
          stretch: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final section = WidgetCatalogPage.catalog[index];
              final widgets = section['widgets'] as List;
              final readCount =
                  widgets
                      .where((w) => widget.readAssets.contains(w['asset']))
                      .length;
              return Card(
                color: Colors.orange[50],
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 22,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepOrange[400]!,
                                  Colors.orange[200]!,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepOrange.withOpacity(0.18),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              section['category'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF795548),
                                letterSpacing: 0.7,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$readCount/${widgets.length} read',
                              style: TextStyle(
                                color: Colors.deepOrange[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children:
                            widgets.map<Widget>((w) {
                              final isRead = widget.readAssets.contains(
                                w['asset'],
                              );
                              return GestureDetector(
                                onTap: () {
                                  final asset = w['asset'];
                                  if (asset != null) widget.onOpenWidget(asset);
                                },
                                child: Chip(
                                  label: Text(
                                    w['name'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isRead
                                              ? Colors.green[900]
                                              : Colors.brown[900],
                                    ),
                                  ),
                                  backgroundColor:
                                      isRead
                                          ? Colors.green[100]
                                          : Colors.orange[50],
                                  avatar: Icon(
                                    isRead ? Icons.check_circle : Icons.widgets,
                                    color:
                                        isRead
                                            ? Colors.green
                                            : Colors.brown[300],
                                    size: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: isRead ? 2 : 0,
                                  shadowColor:
                                      isRead
                                          ? Colors.green.withOpacity(0.15)
                                          : null,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 10,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement quiz functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Starting quiz for ${section['category']}',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.quiz, size: 20),
                          label: const Text(
                            'Start Quiz',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange[400],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: WidgetCatalogPage.catalog.length),
          ),
        ),
      ],
    );
  }
}
