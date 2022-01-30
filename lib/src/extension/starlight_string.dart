part of starlight_search_bar;

extension _StarlightString on String {
  String toSearch() => toLowerCase().replaceAll(' ', '');
}
