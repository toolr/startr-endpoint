library hop_runner;

import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import 'dart:io';
import 'dart:async';

void main(List<String> args) {
  var paths = ['main.dart']; // etc, etc, etc

  addTask('docs', createDartDocTask(paths, linkApi: true));
  
  addTask('analyze_libs', createAnalyzerTask(paths));

  addTask('d2js', createDartCompilerTask(paths));
  
  addTask('watch', createWatchTask(paths));

  runHop(args);
}

Task createWatchTask(List<String> paths) {
  return new Task.sync((TaskContext ctx) {
  	var file = new File(paths[0]);
    ctx.info(paths[0]);
   	print(runTask);
  });
}