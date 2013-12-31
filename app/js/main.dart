import 'dart:html';
import 'dart:convert';
import 'lib/authors.dart';
import 'lib/find.dart';

final DivElement mainContainer = querySelector('.main');
Find find;

void main() {
	
	HttpRequest.getString('/js/data.json').then((data){
		var settings = JSON.decode(data);
		var authors = settings["authors"];

		authors.forEach((v){
			String name = v['name'];
			String url = v['url'];
			var a = new Author(name, url);
			querySelector('.authors').appendHtml(a.element());
		});
	});

	querySelector('.find')
	..onClick.listen(_find)
	..click();


}

void _find(Event e) {
	find = new Find('.main');

}
