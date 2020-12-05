.PHONY: live
live:
	rm -rf build/out/live
	mkdir build/out/live
	cp -r src/static/* build/out/live
	elm-live src/elm/Main.elm --open --dir=./build/out/live --port=8002 -- --output=build/-/index.js --debug

.PHONY: publish
publish:
	rm -r docs
	mkdir docs
	cp -r src/static/* docs
	elm make src/elm/Main.elm --optimize --output=docs/-/index.js
