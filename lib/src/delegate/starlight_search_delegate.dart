part of starlight_search_bar;

class _StarlightSearchBar<T> extends SearchDelegate with _StarlightSearchUtils {
  final List<T> _data;

  bool _isMap = false;

  final bool _debuggingOn;
  final Widget? _leading;
  final List<Widget>? _action;
  final List<String> _targets;

  final Widget Function(T)? _buildSuggestion;
  final Widget Function(T)? _buildResult;

  final Function(T)? _onSuggestionTap;
  final Function(T)? _onResultTap;

  final List<T> Function(List<T>, String)? _onSearch;

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle _subtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _hintStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5),
  );

  _StarlightSearchBar({
    required bool debugQuery,
    required List<T> data,
    List<T> Function(List<T>, String)? onSearch,
    List<String>? targets,
    Widget? leading,
    List<Widget>? action,
    Widget Function(T)? buildSuggestions,
    Widget Function(T)? buildResult,
    Function(T)? onSuggestionTap,
    Function(T)? onResultTap,
    String? searchFieldLabel,
    TextStyle? searchFieldStyle,
    InputDecorationTheme? searchFieldDecorationTheme,
    TextInputType? keyboardType,
    TextInputAction textInputAction = TextInputAction.search,
  })  : _data = data,
        _targets = targets ?? const [],
        _debuggingOn = debugQuery,
        _leading = leading,
        _action = action,
        _buildSuggestion = buildSuggestions,
        _buildResult = buildResult,
        _onSuggestionTap = onSuggestionTap,
        _onResultTap = onResultTap,
        _onSearch = onSearch,
        super(
          searchFieldLabel: searchFieldLabel,
          searchFieldStyle: searchFieldStyle,
          searchFieldDecorationTheme: searchFieldDecorationTheme,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        ) {
    _init();
  }

  void _init() {
    _isMap = _data is List<Map>;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return _action ??
        [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              query = '';
              showSuggestions(context);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return _leading ??
        IconButton(
          splashRadius: 20,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.chevron_left,
          ),
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    return NotificationListener(
      onNotification: overscroll,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: _onSearch == null
            ? search(_data, query, _targets).length + 1
            : _onSearch!(_data, query).length + 1,
        itemBuilder: (_, i) {
          if (i == 0) {
            return Center(
              child: Text(
                "Search result: ${_onSearch == null ? search(_data, query, _targets).length : _onSearch!(_data, query).length} were found.",
                style: _hintStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          return _buildResult == null
              ? InkWell(
                  onTap: () {
                    if (_onResultTap != null) {
                      _onResultTap!(_onSearch == null
                          ? search(_data, query, _targets)[i - 1]
                          : _onSearch!(_data, query)[i - 1]);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _onSearch == null
                              ? _isMap
                                  ? (search(_data, query, _targets)[i - 1]
                                          as Map)[_targets[0]]
                                      .toString()
                                  : search(_data, query, _targets)[i - 1]
                                      .toString()
                              : _isMap
                                  ? (_onSearch!(_data, query)[i - 1]
                                          as Map)[_targets[0].toString()]
                                      .toString()
                                  : _onSearch!(_data, query)[i - 1].toString(),
                          style: _titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          _onSearch == null
                              ? _isMap
                                  ? (search(_data, query, _targets)[i - 1]
                                              as Map)[
                                          _targets[_targets.length > 1 ? 1 : 0]]
                                      .toString()
                                  : search(_data, query, _targets)[i - 1]
                                      .toString()
                              : _isMap
                                  ? (_onSearch!(_data, query)[i - 1] as Map)[
                                          _targets[_targets.length > 1 ? 1 : 0]
                                              .toString()]
                                      .toString()
                                  : _onSearch!(_data, query)[i - 1].toString(),
                          style: _subtitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              : _buildResult!(
                  _onSearch == null
                      ? search(_data, query, _targets)[i - 1]
                      : _onSearch!(_data, query)[i - 1],
                );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_debuggingOn) debugPrint("[Starlight_SearchBar]: query => $query");

    return NotificationListener(
      onNotification: overscroll,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemExtent: _buildSuggestion != null ? null : 50,
        itemCount: _onSearch == null
            ? search(_data, query, _targets).length
            : _onSearch!(_data, query).length,
        itemBuilder: (_, i) => _buildSuggestion == null
            ? InkWell(
                onTap: () {
                  if (_onSuggestionTap != null) {
                    _onSuggestionTap!(_onSearch == null
                        ? search(_data, query, _targets)[i]
                        : _onSearch!(_data, query)[i]);
                  } else {
                    showResults(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _onSearch == null
                            ? _isMap
                                ? (search(_data, query, _targets)[i]
                                        as Map)[_targets[0]]
                                    .toString()
                                : search(_data, query, _targets)[i].toString()
                            : _isMap
                                ? (_onSearch!(_data, query)[i]
                                        as Map)[_targets[0].toString()]
                                    .toString()
                                : _onSearch!(_data, query)[i].toString(),
                        style: _titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        _onSearch == null
                            ? _isMap
                                ? (search(_data, query, _targets)[i] as Map)[
                                        _targets[_targets.length > 1 ? 1 : 0]]
                                    .toString()
                                : search(_data, query, _targets)[i].toString()
                            : _isMap
                                ? (_onSearch!(_data, query)[i] as Map)[
                                        _targets[_targets.length > 1 ? 1 : 0]
                                            .toString()]
                                    .toString()
                                : _onSearch!(_data, query)[i].toString(),
                        style: _subtitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            : _buildSuggestion!(
                _onSearch == null
                    ? search(_data, query, _targets)[i]
                    : _onSearch!(_data, query)[i],
              ),
      ),
    );
  }
}
