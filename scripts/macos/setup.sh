#!/bin/bash
set -e

#
# homebrew
#
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

#
# various dependencies
#
brew install coreutils

# curl
brew install curl
echo 'export PATH="/opt/homebrew/opt/curl/bin:$PATH"' >> ~/.zshrc

# git
brew install git git-lfs
echo 'export PATH="/opt/homebrew/opt/git/bin:$PATH"' >> ~/.zshrc

source ${ZDOTDIR:-$HOME}/.zshrc

#
# asdf
#
brew install asdf
echo '. /opt/homebrew/opt/asdf/libexec/asdf.sh' >> ~/.zshrc
source ${ZDOTDIR:-$HOME}/.zshrc

#
# node.js
#
# dependencies
brew install gpg gawk

# add plugin
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# install versions (asdf list all nodejs)
asdf install nodejs 18.19.0
asdf install nodejs 20.11.0
asdf global nodejs 20.11.0
node -v
npm -v

#
# ruby
#
# dependencies
brew install rust openssl@3 readline libyaml gmp
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# add plugin
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# install versions (asdf list all ruby)
asdf install ruby 3.2.2
asdf global ruby 3.2.2
source ${ZDOTDIR:-$HOME}/.zshrc
ruby --version

# bundler
gem install bundler
bundle --version

# cocoapods
gem install cocoapods
pod --version

#
# python
#
# dependencies
brew install openssl readline sqlite3 xz zlib tcl-tk

# add plugin
asdf plugin add python https://github.com/asdf-community/asdf-python.git

# install versions (asdf list all python)
asdf install python 2.7.18
asdf install python 3.12.1
asdf global python 2.7.18
python --version

#
# golang
#
# add plugin
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

# install versions (asdf list all golang)
asdf install golang 1.21.6
asdf global golang 1.21.6
go version

#
# java
#
brew install jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ${ZDOTDIR:-$HOME}/.zshrc

brew install openjdk@17
jenv add /opt/homebrew/opt/openjdk@17
source ${ZDOTDIR:-$HOME}/.zshrc

jenv global openjdk64-17.0.9
source ${ZDOTDIR:-$HOME}/.zshrc
java --version

jenv enable-plugin export
source ${ZDOTDIR:-$HOME}/.zshrc

#
# android
#
# android-sdk requires Java 8, which requires Rosetta2:
sudo softwareupdate --install-rosetta --agree-to-license

brew install --cask homebrew/cask-versions/temurin8
jenv add /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home
source ${ZDOTDIR:-$HOME}/.zshrc

jenv global 1.8
source ${ZDOTDIR:-$HOME}/.zshrc
java -version

brew install --cask android-sdk

/opt/homebrew/bin/sdkmanager --update

touch ~/.android/repositories.cfg
yes | /opt/homebrew/bin/sdkmanager --licenses

/opt/homebrew/bin/sdkmanager --install "platform-tools" "cmdline-tools;latest" "build-tools;34.0.0" "platforms;android-34" "sources;android-34" "extras;google;m2repository" "extras;android;m2repository"

brew install --cask android-ndk

jenv global openjdk64-17.0.9
source ${ZDOTDIR:-$HOME}/.zshrc

echo 'export ANDROID_HOME="/opt/homebrew/share/android-sdk"' >> ~/.zshrc
echo 'export ANDROID_SDK_ROOT=$ANDROID_HOME' >> ~/.zshrc
echo 'export ANDROID_NDK_HOME="/opt/homebrew/share/android-ndk"' >> ~/.zshrc
source ${ZDOTDIR:-$HOME}/.zshrc

#
# ios / xcode
#
brew install xcodesorg/made/xcodes
brew install aria2
xcodes install 15.2
sudo xcode-select -s /Applications/Xcode-15.2.0.app/Contents/Developer

xcodebuild -runFirstLaunch

# sudo rm -rf /Library/Developer/CommandLineTools
# xcode-select --install

xcodebuild -version
xcrun swift --version
xcode-select --print-path

# xcodes runtimes install "iOS 17.2"

#
# other tools
#
brew install ios-deploy
brew install watchman

brew tap wix/brew
brew install applesimutils

gem install xcpretty
brew install xcbeautify
brew install xclogparser
