#!/bin/sh

echo "\n\n=== Automated Mac Setup v0.2 ==="
echo "\n\n\nChecking '.bash_profile' \n\n"

if [ -r ~/.bash_profile ]; then
  echo "'.bash_profile' exists"
else
  echo "'.bash_profile' does not exists\n"
  touch ~/.bash_profile
  echo 'export PATH=/usr/local/bin:$PATH' >>~/.bash_profile
  chmod 700 ~/.bash_profile
  echo "'.bash_profile' is created"
fi

echo "\n\n\nBREW (HOMEBREW) Mac Package Manager\n\n"
if [ -n `which brew` ]; then
  echo "BREW is already installed"
else
  echo "Installing BREW"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew -v

echo "\n\n\nJAVA AdoptOpenJDK8\n\n"
if [ -n `which java` ]; then
	echo "JAVA is already installed"
else
	echo "Installing JAVA AdoptOpenJDK8"
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
	echo 'export JAVA_HOME=`/usr/libexec/java_home`' >>~/.bash_profile
  echo 'export PATH=$PATH:$JAVA_HOME' >>~/.bash_profile
fi
java -version


echo "\n\n\nGRADLE Package Management\n\n"
if [ -n `which gradle` ]; then
  echo "GRADLE is already installed"
else
  echo "Installing GRADLE"
  brew install gradle
fi
gradle -v

echo "\n\n\nMAVEN Package Management\n\n"
if [ -n `which mvn` ]; then
  echo "MAVEN is already installed"
else
  echo "Installing MAVEN"
  brew install maven
fi
mvn -v

echo "\n\n\nSDKMAN Mac Package Management (Extra)\n\n"
if [ -d "$SDKMAN_DIR" ]; then
	echo "SDKMAN is already installed"
else
  echo "Installing SDKMAN"
	curl -s "https://get.sdkman.io" | bash
fi
sdk version

echo "\n\n\n\Checking GROOVY \n\n"
if [ -n `which groovy` ]; then
  echo "GROOVY is already installed"
else
  echo "Installing GROOVY"
  sdk install groovy
fi
groovy -v

echo "\n\n\n\Checking GRAILS \n\n"
if [ -n `which grails` ]; then
  echo "GRAILS is already installed"
else
  echo "Installing GRAILS"
  sdk install grails
fi
grails -version

echo "\n\n\nGIT Version Management\n\n"
if [ -n `which git` ]; then
  echo "GIT is already installed"
else
  echo "Installing GIT"
  brew install git
fi
git version

echo "\n\n\nDOCKER Container Engine\n\n"

if [ -n `which docker` ]; then
  echo "DOCKER is already installed\n"
else
  echo "Installing DOCKER \n"
  brew tap phinze/homebrew-cask
	brew install brew-cask
	brew cask install docker
fi
docker -v
open /Applications/Docker.app

source ~/.bash_profile

echo "=== Completed ==="
