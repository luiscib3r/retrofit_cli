.PHONY: generate
generate:
	dart run build_runner build

.PHONY: regenerate
regenerate:
	dart run build_runner build --delete-conflicting-outputs

.PHONY: bundle
bundle:
	mason bundle bricks/retrofit_api -t dart -o lib/src/bundles
	mason bundle bricks/class_type -t dart -o lib/src/bundles
	mason bundle bricks/index_file -t dart -o lib/src/bundles
	
.PHONY: test_cli
test_cli:
	rm -r api/
	dart bin/retrofit_cli.dart api

.PHONY: install
install:
	dart pub global activate --source=path .