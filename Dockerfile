FROM python:3.11.2 

USER root

WORKDIR /app

COPY . .

RUN pip3 install --upgrade pip \
	&& pip3 install -r requirements.txt

RUN apt update \
	&& apt-get upgrade -y

RUN apt-get install chromium -y \
	&& apt-get install chromium-driver -y \
	&& apt-get install -y

RUN apt-get install default-jre -y \
	&& wget https://github.com/allure-framework/allure2/releases/download/2.18.1/allure_2.18.1-1_all.deb \
	&& dpkg -i allure_2.18.1-1_all.deb


RUN chmod +x exec_test.sh

CMD ./exec_test.sh