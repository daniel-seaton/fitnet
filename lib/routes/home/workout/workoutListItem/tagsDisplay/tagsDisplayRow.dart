import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/routes/home/workout/workoutListItem/tagsDisplay/tagsDisplay.dart';
import 'package:flutter/material.dart';

class TagsDisplayRow extends StatelessWidget {
  final List<WorkoutStep> steps;

  TagsDisplayRow({@required this.steps});

  @override
  Widget build(BuildContext context) {
    if (this.steps.length == 0) {
      return Container();
    }
    List<Widget> tagsToDisplay = getTagsToDisplay();
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, children: tagsToDisplay),
    );
  }

  List<Widget> getTagsToDisplay() {
    Map<String, int> tagMap = {};
    this.steps.forEach((step) {
      step.exercise.tags.forEach((tag) {
        tagMap[tag] = tagMap.containsKey(tag) ? tagMap[tag] + 1 : 1;
      });
    });
    List<String> tags = tagMap.keys.toList();
    tags.sort((a, b) => tagMap[b] - tagMap[a]);
    var length = 3;
    var showEllipse = false;
    if (tags.length <= 3) {
      length = tags.length;
    } else {
      showEllipse = true;
    }

    List<Widget> tagWidgets = [];
    for (var i = 0; i < length; i++) {
      tagWidgets.add(TagDisplay(tag: tags[i]));
    }
    if (showEllipse) {
      tagWidgets.add(Text(". . .",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
    }
    return tagWidgets;
  }
}
