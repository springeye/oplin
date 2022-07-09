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
  final ViewSortType sort;
  final String? search;

  //show all when notebook is null,show unclassified notebook.uuid is empty,
  final Book? notebook;

  const NoteViewFilter(
      {this.sort = ViewSortType.updatedDesc, this.search, this.notebook});

  NoteViewFilter copyWith({
    ViewSortType Function()? sort,
    String? Function()? search,
    Book? Function()? notebook,
  }) {
    return NoteViewFilter(
      sort: sort != null ? sort() : this.sort,
      search: search != null ? search() : this.search,
      notebook: notebook != null ? notebook() : this.notebook,
    );
  }

  @override
  List<Object?> get props => [sort, search, notebook?.uuid];

  List<Note> applyAll(List<Note> notes) {
    appLog.debug("applyAll filter");
    var result = [...notes];
    result = result.where((element) {
      var show = element.notebookId == notebook?.uuid && !element.deleted;
      if (notebook == null) {
        show = !element.deleted;
      } else if (notebook != null && notebook!.isOther) {
        show = element.notebookId == null && !element.deleted;
      } else if (notebook != null && notebook!.isRecycled) {
        show = element.deleted;
      }

      if (search != null) {
        show = show &&
            (element.title.contains(search!) ||
                element.content.toPlainText().contains(search!));
      }
      return show;
    }).toList();
    sort.sortAll(result);
    return result;
  }
}
