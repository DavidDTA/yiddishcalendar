live:
	rm -r build
	mkdir build
	cp -r src/static/* build
	elm-live src/elm/Main.elm --open --dir=./build -- --output=build/-/index.js

publish:
	rm -r docs
	mkdir docs
	cp -r src/static/* docs
	elm make src/elm/Main.elm --optimize --output=docs/-/index.js
