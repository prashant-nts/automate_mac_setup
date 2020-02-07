#!/bin/sh

printf "\n=== Automated Mac Setup v0.4 === \n\n"

declare -a task_done
if [ ! -r ~/.bash_profile ]; then
  touch ~/.bash_profile
  echo 'export PATH=/usr/local/bin:$PATH' >>~/.bash_profile
  chmod 700 ~/.bash_profile
fi
task_done+=(.bash_profile---build)
if [ ! -n `which brew` ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap caskroom/cask
fi
task_done+=(Homebrew----installed)
if [ ! -n `which java` ]; then
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
	echo 'export JAVA_HOME=`/usr/libexec/java_home`' >>~/.bash_profile
  echo 'export PATH=$PATH:$JAVA_HOME' >>~/.bash_profile
fi
task_done+=(OpenJDK8----installed)
if [ ! -n `which gradle` ]; then
  brew install gradle
fi
task_done+=(Gradle------installed)
if [ ! -n `which mvn` ]; then
  brew install maven
fi
task_done+=(Maven-------installed)
if [ ! -d "$SDKMAN_DIR" ]; then
	curl -s "https://get.sdkman.io" | bash
fi
task_done+=(SdkMan------installed)
if [ ! -n `which groovy` ]; then
  sdk install groovy
fi
task_done+=(Groovy------installed)
if [ ! -n `which grails` ]; then
  sdk install grails
fi
task_done+=(Grails------installed)
if [ ! -n `which git` ]; then
  brew install git
fi
task_done+=(Git---------installed)
brew cask install postman
task_done+=(Postman-----installed)
brew cask install sourcetree
task_done+=(sourcetree--installed)
brew cask install visual-studio-code
task_done+=(VSCode------installed)
brew cask install intellij-idea
task_done+=(IntelliJ----installed)
#brew cask install google-chrome
#task_done+=(Chrome------installed)
echo '### USEFUL ALIAS FOR TERMINAL' >>~/.bash_profile
echo "alias lf='ls -lhF -a'" >>~/.bash_profile
echo "alias ll='ls -ltr -a'" >>~/.bash_profile
echo "parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' }" >>~/.bash_profile
echo 'export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "' >>~/.bash_profile

if [ ! -n `which docker` ]; then
  brew tap phinze/homebrew-cask
	brew install brew-cask
	brew cask install docker
fi
task_done+=(Docker-------installed)
for i in ${task_done[@]}
do
  echo $i
done

source ~/.bash_profile
open /Applications/Docker.app
printf "\n=== Completed === \n\n"


