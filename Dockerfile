FROM --platform=$TARGETPLATFORM debian:bookworm
ARG TARGETPLATFORM
WORKDIR /app
COPY ./requirements-omar.txt /app
COPY ./requirements-pi2.txt /app
RUN apt update && apt install -y build-essential
RUN apt install ffmpeg libsm6 libxext6 python3-pip python3-venv -y

RUN if [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then \
	echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
  	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 82B129927FA3303E && \
	apt update && \
	apt install -y \
         python3-picamera2 \
	&& apt-get clean \
     	&& apt-get autoremove \
     	&& rm -rf /var/cache/apt/archives/* \
     	&& rm -rf /var/lib/apt/lists/*; \
fi

	
RUN python3 -m venv --system-site-packages env

RUN . env/bin/activate

RUN if [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then \
	./env/bin/pip3 install -r requirements-pi2.txt;\
fi

RUN if [ "$TARGETPLATFORM" = "linux/arm64/v8" ]; then \
	./env/bin/pip3 install -r requirements-omar.txt;\
fi

COPY . .
EXPOSE 5000 
CMD ["./env/bin/python3", "app.py", "--host", "0.0.0.0"]
