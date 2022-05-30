

class SearchType {

  final String mainCategory;
  final List<int> categories;
  final List<int> applicationsSupported;
  final List<int> fileTypes;
  final List<int> frame;
  final List<int> genre;
  final List<int> language;
  final List<int> platform;
  final List<int> situation;
  final int currentPage;
  final String selected;
  final String search;

  SearchType(
      {
      required this.mainCategory,
      required this.categories,
      required this.applicationsSupported,
      required this.fileTypes,
      required this.frame,
      required this.genre,
      required this.language,
      required this.platform,
      required this.situation,
      required this.currentPage,
      required this.selected,
      required this.search
      });

  factory SearchType.fromJson(Map<String, dynamic> json) {
    return SearchType(
        mainCategory : json['mainCategory'],
        categories : json['categories'],
        applicationsSupported : json['applicationsSupported'],
        fileTypes : json['fileTypes'],
        frame : json['frame'],
        genre : json['genre'],
        language : json['language'],
        platform : json['platform'],
        situation : json['situation'],
        currentPage : json['currentPage'],
        selected : json['selected'],
        search : json['search'],
    );
  }

  Map getSearchType () {
    return {
      'mainCategory': this.mainCategory,
      'categories' : this.categories,
      'applicationsSupported' : this.applicationsSupported,
      'fileTypes' : this.fileTypes,
      'frame' : this.frame,
      'genre' : this.genre,
      'language' : this.language,
      'platform' : this.platform,
      'situation' : this.situation,
      'currentPage': this.currentPage,
      'selected' : this.selected,
      'search' : this.search == "" ? null : this.search,
    };
  }

}
