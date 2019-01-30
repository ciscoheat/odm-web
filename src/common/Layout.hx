import mithril.M;

// View
class Layout implements Mithril
{
	public function new() {}

	public function layout(view : Dynamic) 
		m('.flex-vertical.flex-center', m('.container', [
			m('header.flex-center', m('img[src=logo.png]#logo')),
			m('main', m(view))
		]));
}
