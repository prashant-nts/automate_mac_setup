#!/bin/sh

echo "\n\n=== Automated Mac Setup v0.1 ==="

echo "\n\nBREW (HOMEBREW) Mac Package Manager\n\n"

if [ -n `which brew` ]; then
        echo "BREW is already installed\n"
        brew_version=$((brew -v) 2>&1)
        echo "$brew_version \n"
else
        echo "Installing BREW\n"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "\n\nJAVA AdoptOpenJDK8\n\n"

if [ -n `which java` ]; then
	echo "JAVA is already installed\n"
	java_version=$((java -version) 2>&1)
	echo "$java_version \n"
else
	echo "Installing JAVA AdoptOpenJDK8 \n"
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
	java -version
fi

echo "\n\nGRADLE Package Management\n\n"

if [ -n `which gradle` ]; then
        echo "GRADLE is already installed\n"
        gradle_version=$((gradle -v) 2>&1)
        echo "$gradle_version \n"
else
        echo "Installing GRADLE \n"
        brew install gradle
fi

echo "\n\nMAVEN Package Management\n\n"

	brew install maven
	mvn -v

echo "\n\nSDKMAN Mac Package Management (Extra)\n\n"

	curl -s "https://get.sdkman.io" | bash

echo "\n\nGIT Version Management\n\n"

if [ -n `which git` ]; then
        echo "GIT is already installed\n"
        git_version=$((git version) 2>&1)
        echo "$git_version \n"
else
        echo "Installing GIT \n"
        brew install git
fi

echo "\n\nDOCKER Container Engine\n\n"

if [ -n `which docker` ]; then
        echo "DOCKER is already installed\n"
        docker_version=$((docker -v) 2>&1)
        echo "$docker_version \n"
else
        echo "Installing DOCKER \n"
        brew tap phinze/homebrew-cask
	brew install brew-cask
	brew cask install docker
	open /Applications/Docker.app
	docker -v
fi

echo "=== Completed ==="
echo "== RUN THE NEXT SCRIPT =="
