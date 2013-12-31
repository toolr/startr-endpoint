import 'dart:html';

class Repo {
	String name;
	String url;
	String clone_url;
	String description;
	List<String> languages;
	List<String> authors;
	String args;
	StreamSubscription useClickListener;
	StreamSubscription useKeyboardListener;
	StreamSubscription infoClickListener;
	StreamSubscription infoKeyboardListener;

	Repo();

	factory Repo.fromMap(Map map) {
		var repo = new Repo();
		repo.name = map['name'];
		repo.url = map['url'];
		repo.clone_url = map['clone_url'];
		repo.description = map['description'];
		repo.languages = map['languages'];
		repo.authors = map['authors'];
		repo.args = map['args'];
		return repo;
	}

	void use(Event e){

		if(querySelector('.use')==null) {
			document.body.children.add(usePopup());

			useClickListener = document.body.onClick.listen((e){
				if(!e.target.matchesWithAncestors('.use') || e.target.matchesWithAncestors('button.close')){
					var use = querySelector('.use');
					if (use != null) querySelector('.use').remove();
					if (useClickListener !=null) useClickListener.pause();
				}
			});

			useKeyboardListener = document.body.onKeyDown.listen((e){
				if(e.keyCode == 27){
					if (use != null) querySelector('.use').remove();
					if (useKeyboardListener !=null) useKeyboardListener.pause();
				}
			});
		}
	}

	void info(Event e) {
		if(querySelector('.info') == null) {
			querySelectorAll('table button').forEach((button){
				button.disabled = true;
			});
			document.body.children.add(infoPopup());
			var close = querySelector('button.close');
			var info = querySelector('.info');
			close.onClick.listen((e){
				if (info != null) querySelector('.info').remove();
				querySelectorAll('table button').forEach((button){
					button.disabled = false;
				});
			});

			infoKeyboardListener = document.body.onKeyDown.listen((e){
				if(e.keyCode == 27){
					if (info != null) querySelector('.info').remove();
					if (infoKeyboardListener !=null) infoKeyboardListener.pause();
					querySelectorAll('table button').forEach((button){
						button.disabled = false;
					});
				}
			});
		} 
	}


	DivElement usePopup() {
		var popup = new DivElement();
		popup.classes.add("use");
		popup.innerHtml = 
		"""
				<div class="outerCode">
					<div class="innerCode">
						<div class="code">|yo| startr get $name $args</div>
					</div>
				</div>
				<div class="controls">
					<button class="close">CLOSE</button>
				</div>
		""";
		return popup;
	}

	DivElement infoPopup() {
		var popup = new DivElement();
		popup.classes.add("info");
		var innerHtml =
		"""
			<div class="outerInput"><div class="innerInput"><input type="text" class="name" value="$name"/></div></div>
			<div class="outerInput"><div class="innerInput"><input type="text" class="description" value="$description"/></div></div>
			<div class="url"><a target="new" href="$url">$url</a></div>
			<div class="authorsList">Author(s): ${authorList()}</div>
			<div class="clone_url"></div>
			<div class="languageList"></div>
			<div class="controls">
				<button class="save">SAVE</button>
				<button class="delete">DELETE</button>
				<button class="close">CLOSE</button>
			</div>
		
		""";
		popup.setInnerHtml(innerHtml, 
			validator: new NodeValidatorBuilder()
        	..allowTextElements()
        	..allowHtml5()
        	..allowElement('a', attributes: ['href'])
        );
		return popup;
	}	

	String authorList() {
		String html = "";
		authors.forEach((author){
			html += """
				<span><a target="new" href="https://github.com/$author">$author</a></span>
			""";
		});
		return html;
	}

	String languageList() {

	}

	int startRd() {
		return 0;
	}
}