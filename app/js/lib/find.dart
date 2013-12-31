import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'repo.dart';

class Find {

	String _html = """
	<div class="search">
		<div class="outerSearch">
			<div class="innerSearch"><input type="text" class="search" type="text"></div>
		</div>
		<button class="search"><i class="fa fa-search"></i></button>
	</div>
	<table>
		<thead>
			<td>Name</td>
			<td>Description</td>
			<td>startR'd</td>
			<td></td>
		</thead>
	</table>

	""";

	DivElement container;
	TableElement table;
	Map repoMap = {};

	Find(String selector) {
		this.container = querySelector(selector);
		_build();
	}

	void _build() {
		this.container.children.clear();
		this.container.innerHtml = _html;

		table = this.container.querySelector('table');

		_repos()
		.then((repoList){
			repoList.forEach((repo){
				var row = new TableRowElement();
				row.classes.add(repo.name);
				row.innerHtml = """
					<td>${repo.name}</td>
					<td>${repo.description}</td>
					<td>${repo.startRd()}</td>
					<td>
						<button id="${repo.name}.gears"><i class="fa fa-gears"></i></button>
					</td>
				""";
				table.children.add(row);
				row.onDoubleClick.listen(repo.use);

				repoMap[repo.name] = repo;
			});



			var buttons = table.querySelectorAll('button');
			buttons.forEach((button){
				var id = button.id;
				
				if(id.endsWith("gears")) {
					id = id.replaceAll(".gears","");
					var repo = repoMap[id];
					button.onClick.listen(repo.info);
				}
			});
		});
	}

	Future<List<Repo>> _repos() {

		if(window.location.hostname == "localhost") {
			var completer = new Completer();
		
			HttpRequest.getString('/js/mock.json').then((data){
				var repolist = [];
				var map = JSON.decode(data);
				var l = map["list"];
				l.forEach((i){
					var r = new Repo.fromMap(i);
					repolist.add(r);
				});
				completer.complete(repolist);
			});

			return completer.future;
		}		
	}
}