import '../models/catalog_section.dart';
import '../models/topic_manifest.dart';
import 'app_config_service.dart';
import 'topics_manifest_repository.dart';

class CatalogService {
  const CatalogService();

  static const List<Map<String, dynamic>> legacyCatalog = [
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
      'category': 'Async Widgets',
      'widgets': [
        {'name': 'Future Builder', 'asset': 'assets/futurebuilder.md'},
        {'name': 'Stream Builder', 'asset': 'assets/streambuilder.md'},
      ],
    },
    {
      'category': 'Interaction Models',
      'widgets': [
        {'name': 'Dismissible', 'asset': 'assets/dismissible.md'},
        {'name': 'Draggable', 'asset': 'assets/draggable.md'},
        {'name': 'Interactive Viewer', 'asset': 'assets/interactiveviewer.md'},
      ],
    },
    {
      'category': 'Painting & Effects',
      'widgets': [
        {'name': 'ClipRRect', 'asset': 'assets/cliprrect.md'},
        {'name': 'Transform', 'asset': 'assets/transform.md'},
        {'name': 'Backdrop Filter', 'asset': 'assets/backdropfilter.md'},
      ],
    },
    {
      'category': 'Indicators & Chips',
      'widgets': [
        {'name': 'Circular Progress', 'asset': 'assets/circularprogressindicator.md'},
        {'name': 'Linear Progress', 'asset': 'assets/linearprogressindicator.md'},
        {'name': 'Chip', 'asset': 'assets/chip.md'},
        {'name': 'Circle Avatar', 'asset': 'assets/circleavatar.md'},
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

  Future<List<CatalogSection>> loadCatalogSections() async {
    try {
      final manifest = await topicsManifestRepository.loadManifest();
      final topicsById = manifest.topicsById;
      final manifestSections = <CatalogSection>[];
      final manifestAssetPaths = <String>{};

      for (final track in await topicsManifestRepository.loadTracks()) {
        final items = track.topicIds
            .map((topicId) => topicsById[topicId])
            .whereType<TopicMetadata>()
            .map(
              (topic) => CatalogItem(
                name: topic.title,
                assetPath: topic.lessonAsset,
                quizAssetPath: topic.quizAsset,
                topicId: topic.id,
                category: topic.category,
                level: topic.level,
                type: topic.type,
                estimatedMinutes: topic.estimatedMinutes,
                prerequisites: topic.prerequisites,
              ),
            )
            .toList();

        if (items.isEmpty) {
          continue;
        }

        manifestAssetPaths.addAll(items.map((item) => item.assetPath));
        manifestSections.add(
          CatalogSection(
            title: track.title,
            description: track.description,
            level: track.level,
            items: items,
          ),
        );
      }

      final fallbackSections =
          appConfigService.config.features.enableLegacyCatalogFallback
          ? _legacySectionsExcluding(manifestAssetPaths)
          : const <CatalogSection>[];
      if (manifestSections.isEmpty) {
        return fallbackSections;
      }

      return [...manifestSections, ...fallbackSections];
    } catch (_) {
      if (appConfigService.config.features.enableLegacyCatalogFallback) {
        return _legacySectionsExcluding(const <String>{});
      }
      return const <CatalogSection>[];
    }
  }

  List<CatalogSection> _legacySectionsExcluding(Set<String> excludedAssetPaths) {
    return legacyCatalog
        .map((section) {
          final items = (section['widgets'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .where((item) => !excludedAssetPaths.contains(item['asset'] as String))
              .map(
                (item) => CatalogItem(
                  name: item['name'] as String,
                  assetPath: item['asset'] as String,
                  quizAssetPath:
                      '${(item['asset'] as String).replaceAll('.md', '')}_quiz.json',
                  category: section['category'] as String,
                  level: 'reference',
                  type: 'widget',
                  isLegacy: true,
                ),
              )
              .toList();

          if (items.isEmpty) {
            return null;
          }

          return CatalogSection(
            title: section['category'] as String,
            items: items,
          );
        })
        .whereType<CatalogSection>()
        .toList();
  }
}

const catalogService = CatalogService();
