FROM angr/angr

USER root

RUN apt update \
	&& apt install -y \
		unzip \
		python-six

USER angr
WORKDIR /home/angr

RUN ~/.virtualenvs/angr/bin/pip install cvc4-solver \
	&& git clone https://github.com/angr/pysoot.git \
	&& cd pysoot \
	&& ~/.virtualenvs/angr/bin/pip install -e . \
	&& cd .. \
	&& ~/.virtualenvs/angr/bin/pip uninstall --yes pysmt \
	&& git clone https://github.com/pysmt/pysmt.git \
	&& cd pysmt \
	&& git checkout 6d792db47be5f8734db15848faca9bc6b770085e \
	&& ~/.virtualenvs/angr/bin/pip install -e . \
	&& cd .. \
	&& ~/.virtualenvs/angr/bin/pip uninstall --yes six \
	&& ~/.virtualenvs/angr/bin/pip install six

USER root

RUN mkdir /home/angr/Android \
	&& \
	cd /home/angr/Android \
	&& \
	wget https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip \
	&& \
	unzip commandlinetools-linux-6514223_latest.zip -d cmdline-tools \
	&& \
	yes | cmdline-tools/tools/bin/sdkmanager --sdk_root=/home/angr/Android/Sdk "platforms;android-21" "platform-tools"

