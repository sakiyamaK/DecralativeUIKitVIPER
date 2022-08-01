setup:
	./scripts/setup.sh
	open DecralativeUIKitVIPER.xcworkspace
.PHONY: setup

swiftgen:
	./Pods/SwiftGen/bin/swiftgen config lint
	./Pods/SwiftGen/bin/swiftgen config run
.PHONY: swiftgen

clean:
	./scripts/clean.sh
.PHONY: setup

component:
	mint run pui component VIPER ${name}
.PHONY: component

release:
	bundle exec fastlane release
.PHONY: release
