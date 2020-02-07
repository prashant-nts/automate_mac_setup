#!/bin/sh

printf "\n=== Automated Mac Setup v0.4 === \n\n"

declare -a task_done
if [ ! -r ~/.bash_profile ]; then
  touch ~/.bash_profile
  echo 'export PATH=/usr/local/bin:$PATH' >>~/.bash_profile
  chmod 700 ~/.bash_profile
  task_done+=(.bash_profile---build)
fi
if [ -n `which brew` ]; then
	echo ""
else
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap caskroom/cask
	task_done+=(Homebrew----installed)
fi
if [ -n `which java` ]; then
	echo ""
else
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
	echo 'export JAVA_HOME=`/usr/libexec/java_home`' >>~/.bash_profile
  echo 'export PATH=$PATH:$JAVA_HOME' >>~/.bash_profile
  task_done+=(OpenJDK8----installed)
fi
if [ -n `which gradle` ]; then
	echo ""
else
  brew install gradle
  task_done+=(Gradle------installed)
fi
if [ -n `which mvn` ]; then
	echo ""
else
  brew install maven
  task_done+=(Maven-------installed)
fi

if [ ! -d "$SDKMAN_DIR" ]; then
	curl -s "https://get.sdkman.io" | bash
	task_done+=(SdkMan------installed)
fi

if [ -n `which groovy` ]; then
	echo ""
else
  sdk install groovy
  task_done+=(Groovy------installed)
fi

if [ -n `which grails` ]; then
	echo ""
else
  sdk install grails
  task_done+=(Grails------installed)
fi

if [ -n `which git` ]; then
	echo ""
else
  brew install git
  task_done+=(Git---------installed)
fi
brew cask install postman
task_done+=(Postman-----installed)
brew cask install sourcetree
task_done+=(sourcetree--installed)
brew cask install visual-studio-code
task_done+=(VSCode------installed)
brew cask install intellij-idea
task_done+=(IntelliJ----installed)
brew cask install mysqlworkbench
task_done+=(workbench---installed)
#brew cask install google-chrome
#task_done+=(Chrome------installed)
echo '### USEFUL ALIAS FOR TERMINAL' >>~/.bash_profile
echo "alias lf='ls -lhF -a'" >>~/.bash_profile
echo "alias ll='ls -ltr -a'" >>~/.bash_profile
echo "parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' }" >>~/.bash_profile
echo 'export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "' >>~/.bash_profile

if [ -n `which docker` ]; then
	echo ""
else
  	brew tap phinze/homebrew-cask
	brew install brew-cask
	brew cask install docker
	task_done+=(Docker-------installed)
fi
for i in ${task_done[@]}
do
  echo $i
done

source ~/.bash_profile
open /Applications/Docker.app
printf "\n=== Completed === \n\n"


