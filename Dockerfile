FROM angr/angr

RUN apt update \
	&& \
	apt install unzip

RUN mkdir /home/angr/Android \
	&& \
	cd /home/angr/Android \
	&& \
	wget https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip \
	&& \
	unzip commandlinetools-linux-6514223_latest.zip -d cmdline-tools \
	&& \
	yes | cmdline-tools/tools/bin/sdkmanager --sdk_root=/home/angr/Android/Sdk "platforms;android-21" "platform-tools"

