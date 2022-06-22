import 'package:flutter/material.dart';

enum ViewSortType {
  title,
  titleDesc,
  updated,
  updatedDesc,
  created,
  createdDesc
}

extension ViewSortTypeX on ViewSortType {
  String getTitle(BuildContext context) {
    switch (this) {
      case ViewSortType.title:
        return 'title ↑';
      case ViewSortType.titleDesc:
        return 'title ↓';
      case ViewSortType.updated:
        return 'update ↑';
      case ViewSortType.updatedDesc:
        return 'update ↓';
      case ViewSortType.created:
        return 'create ↑';
      case ViewSortType.createdDesc:
        return 'create ↓';
    }
  }
}
