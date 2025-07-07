import 'package:flutter/material.dart';

class WidgetCatalogPage extends StatelessWidget {
  final Set<String> readAssets;
  final void Function(String assetPath) onOpenWidget;

  const WidgetCatalogPage({
    Key? key,
    required this.readAssets,
    required this.onOpenWidget,
  }) : super(key: key);

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
    // ... Add more categories and widgets as needed ...
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,
          backgroundColor: Colors.deepOrange[400],
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
              final section = catalog[index];
              final widgets = section['widgets'] as List;
              final readCount =
                  widgets.where((w) => readAssets.contains(w['asset'])).length;
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
                              final isRead = readAssets.contains(w['asset']);
                              return GestureDetector(
                                onTap: () {
                                  final asset = w['asset'];
                                  if (asset != null) onOpenWidget(asset);
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
                    ],
                  ),
                ),
              );
            }, childCount: catalog.length),
          ),
        ),
      ],
    );
  }
}
