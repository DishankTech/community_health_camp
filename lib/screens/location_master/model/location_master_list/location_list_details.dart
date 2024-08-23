import 'location_list_data.dart';

class LocationListDetails {
  LocationListDetails({
      this.totalPages, 
      this.page, 
      this.totalCount, 
      this.perPage, 
      this.data,});

  LocationListDetails.fromJson(dynamic json) {
    totalPages = json['total_pages'];
    page = json['page'];
    totalCount = json['total_count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LocationListData.fromJson(v));
      });
    }
  }
  int? totalPages;
  int? page;
  int? totalCount;
  int? perPage;
  List<LocationListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_pages'] = totalPages;
    map['page'] = page;
    map['total_count'] = totalCount;
    map['per_page'] = perPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}