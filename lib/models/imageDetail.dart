// To parse this JSON data, do
//
//     final imageDetail = imageDetailFromJson(jsonString);

import 'dart:convert';

ImageDetail imageDetailFromJson(String str) =>
    ImageDetail.fromJson(json.decode(str));

String imageDetailToJson(ImageDetail data) => json.encode(data.toJson());

class ImageDetail {
  ImageDetail({
    this.fileName,
  });

  String fileName;

  factory ImageDetail.fromJson(Map<String, dynamic> json) => ImageDetail(
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
      };
}
