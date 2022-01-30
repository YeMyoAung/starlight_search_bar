part of starlight_search_bar;

class _StarlightSearchUtils<T> {
  List<T> search(
    List<T> data,
    String query,
    List<String> targets,
  ) {
    if (data.isEmpty) return [];

    if (data is List<Map>) {
      if (targets.isEmpty) {
        throw const _StarlightException(
          error: "Target is empty.",
          message:
              '''If you want to provide a map,you need to provide targets''',
        );
      }
      for (String target in targets) {
        try {
          data
              .where(
                (parse) => (parse as Map)[target]
                    .toString()
                    .toSearch()
                    .contains(query.toSearch()),
              )
              .toList();
        } catch (e) {
          throw const _StarlightException(
            error: "Data Type Exception",
            message:
                '''We only accept List<Map>,List<String>,List<int>,List<double> and List<bool>.If you want to provide your own model or own class you can use `onSearch` method.''',
          );
        }
      }
    }
    return data
        .where(
            (chunk) => chunk.toString().toSearch().contains(query.toSearch()))
        .toList();
  }

  bool overscroll(OverscrollIndicatorNotification notification) {
    notification.disallowIndicator();
    return false;
  }
}
