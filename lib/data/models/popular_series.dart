import 'dart:convert';

import 'package:tv_app/data/models/series.dart';

PopularSeries popularSeriesFromJson(String str) => PopularSeries.fromJson(json.decode(str));

String popularSeriesToJson(PopularSeries data) => json.encode(data.toJson());

class PopularSeries {
  int page;
  List<Series> series;
  int totalPages;
  int totalResults;

  PopularSeries({
    required this.page,
    required this.series,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularSeries.fromJson(Map<String, dynamic> json) => PopularSeries(
    page: json["page"],
    series: List<Series>.from(json["results"].map((x) => Series.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(series.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
