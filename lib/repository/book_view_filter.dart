import 'package:equatable/equatable.dart';
import 'package:oplin/common/logging.dart';

import '../db/models.dart';
import 'view_filter_type.dart';

extension NotebookViewFilterTypeX on ViewFilterType {
  bool apply(Book book) {
    switch (this) {
      case ViewFilterType.all:
        return true;
      case ViewFilterType.activeOnly:
        return !book.deleted;
      case ViewFilterType.deletedOnly:
        return book.deleted;
    }
  }

  Iterable<Book> applyAll(Iterable<Book> notes) {
    return notes.where(apply);
  }
}

class NotebookViewFilter extends Equatable {
  final ViewFilterType type;
  final String? search;
  final String? notebookId;

  const NotebookViewFilter(
      {this.type = ViewFilterType.activeOnly, this.search, this.notebookId});

  NotebookViewFilter copyWith({
    ViewFilterType Function()? type,
    String? Function()? search,
    String? Function()? notebookId,
  }) {
    return NotebookViewFilter(
      type: type != null ? type() : this.type,
      search: search != null ? search() : this.search,
      notebookId: notebookId != null ? notebookId() : this.notebookId,
    );
  }

  @override
  List<Object?> get props => [type, search, notebookId];

  List<Book> applyAll(List<Book> notes) {
    appLog.debug("applyAll filter");
    var result = [...notes];
    result = result.where((element) {
      var show = true;
      if (search != null) {
        show = show && (element.name.contains(search!));
      }
      if (type == ViewFilterType.deletedOnly) {
        show = show && element.deleted;
      }
      if (type == ViewFilterType.activeOnly) {
        show = show && !element.deleted;
      }
      return show;
    }).toList();
    return result;
  }
}
