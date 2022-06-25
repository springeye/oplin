import 'package:equatable/equatable.dart';
import 'package:oplin/common/logging.dart';

import '../db/models.dart';
import 'view_filter_type.dart';
import 'view_sort_type.dart';

extension NoteViewFilterTypeX on ViewFilterType {
  bool apply(Note note) {
    switch (this) {
      case ViewFilterType.all:
        return true;
      case ViewFilterType.activeOnly:
        return !note.deleted;
      case ViewFilterType.deletedOnly:
        return note.deleted;
    }
  }

  Iterable<Note> applyAll(Iterable<Note> notes) {
    return notes.where(apply);
  }
}

extension NoteViewSortTypeX on ViewSortType {
  int sort(Note a, Note b) {
    switch (this) {
      case ViewSortType.title:
        return a.title.compareTo(b.title);
      case ViewSortType.created:
        return a.createTime.compareTo(b.createTime);
      case ViewSortType.updated:
        return a.updateTime.compareTo(b.updateTime);
      case ViewSortType.titleDesc:
        return b.updateTime.compareTo(a.updateTime);
      case ViewSortType.updatedDesc:
        return b.updateTime.compareTo(a.updateTime);
      case ViewSortType.createdDesc:
        return b.updateTime.compareTo(a.updateTime);
    }
  }

  List<Note> sortAll(List<Note> notes) {
    return notes..sort(sort);
  }
}

class NoteViewFilter extends Equatable {
  final ViewFilterType type;
  final ViewSortType sort;
  final String? search;

  //show all when notebook is null,show unclassified notebook.uuid is empty,
  final Notebook? notebook;

  const NoteViewFilter(
      {this.type = ViewFilterType.activeOnly,
      this.sort = ViewSortType.updatedDesc,
      this.search,
      this.notebook});

  NoteViewFilter copyWith({
    ViewFilterType Function()? type,
    ViewSortType Function()? sort,
    String? Function()? search,
    Notebook? Function()? notebook,
  }) {
    return NoteViewFilter(
      type: type != null ? type() : this.type,
      sort: sort != null ? sort() : this.sort,
      search: search != null ? search() : this.search,
      notebook: notebook != null ? notebook() : this.notebook,
    );
  }

  @override
  List<Object?> get props => [type, sort, search, notebook?.uuid];

  List<Note> applyAll(List<Note> notes) {
    appLog.debug("applyAll filter");
    var result = [...notes];
    result = result.where((element) {
      var show = element.notebookId == notebook?.uuid;
      if (notebook == null) {
        show = true;
      } else if (notebook != null && notebook!.isOther) {
        show = element.notebookId == null;
      }

      if (search != null) {
        show = show &&
            (element.title.contains(search!) ||
                element.content.toPlainText().contains(search!));
      }
      if (type == ViewFilterType.deletedOnly) {
        show = show && element.deleted;
      }
      if (type == ViewFilterType.activeOnly) {
        show = show && !element.deleted;
      }
      return show;
    }).toList();
    sort.sortAll(result);
    return result;
  }
}
