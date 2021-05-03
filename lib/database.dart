import 'package:flutter/cupertino.dart';
import 'package:my_app_groupproject/models/posts_class.dart';


class Posts {

  final String Title;
  final String Body;
  final String RefId;
  final String OwnerId;
  final int Date;

  Posts({
    @required this.Title,
    @required this.Body,
    @required this.RefId,
    @required this.OwnerId,
    @required this.Date
  });

  Map<String, dynamic> toJson() =>
      {
        'title': Title,
        'Body': Body,
        'RefId': RefId,
        'OwnerId':OwnerId,
        'Date':Date
      };

}