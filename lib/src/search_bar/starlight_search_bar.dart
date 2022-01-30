part of starlight_search_bar;

abstract class StarlightSearchBar {
  ///Starlight Search Bar will appear
  static void searchBar<T>({
    ///if you want to see query data,you need to set true
    bool debugQuery = false,

    ///BuildContext is required
    required BuildContext context,

    ///Search Data is required
    required List<T> data,

    ///If you provide a list of map, you will need to provide the key of map
    List<String>? targets,

    ///if you want to show custom suggestion ,you can provide a widget
    Widget Function(T)? buildSuggestion,

    ///if you want to show custom result ,you can provide a widget
    Widget Function(T)? buildResult,

    ///if you want to do something after on tap at suggestion,you can provide a function with a parameter
    Function(T)? onSuggestionTap,

    ///if you want to do something after on tap at result,you can provide a function with a parameter
    Function(T)? onResultTap,

    ///if you want to set custom search,you can provide a function with two parameter
    List<T> Function(List<T>, String)? onSearch,

    ///if you want to show custom leading ,you can provide a widget
    Widget? leading,

    ///if you want to show custom action ,you can provide a list of widget
    List<Widget>? action,

    ///if you want to show custom search field label ,you can provide a string
    String? searchFieldLabel,

    ///if you want to show custom search field label ,you can provide a text style
    TextStyle? searchFieldStyle,

    ///if you want to show custom search field label ,you can provide an input decoration theme
    InputDecorationTheme? searchFieldDecorationTheme,

    ///if you want to show custom keyboard type ,you can provide a keyboard type
    TextInputType? keyboardType,

    ///if you want to work with custom action ,you can provide an input action
    TextInputAction textInputAction = TextInputAction.search,
  }) =>
      showSearch(
        context: context,
        delegate: _StarlightSearchBar(
          data: data,
          targets: targets,
          debugQuery: debugQuery,
          onSearch: onSearch,
          leading: leading,
          action: action,
          buildSuggestions: buildSuggestion,
          buildResult: buildResult,
          onSuggestionTap: onSuggestionTap,
          onResultTap: onResultTap,
          searchFieldLabel: searchFieldLabel,
          searchFieldStyle: searchFieldStyle,
          searchFieldDecorationTheme: searchFieldDecorationTheme,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        ),
      );
}
