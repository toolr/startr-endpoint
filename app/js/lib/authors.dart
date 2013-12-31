import 'dart:html';

class Author {
	String name;
	String url;

	Author(this.name, this.url);

	String element() {
		return "<span><a href='${this.url}'>${this.name}</a></span>";
	}
}