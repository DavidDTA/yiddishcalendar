live:
	rm -rf build
	mkdir build
	cp -r src/static/* build
	elm-live src/elm/Main.elm --open --dir=./build -- --output=build/-/index.js --debug

publish:
	rm -r docs
	mkdir docs
	cp -r src/static/* docs
	elm make src/elm/Main.elm --optimize --output=docs/-/index.js
