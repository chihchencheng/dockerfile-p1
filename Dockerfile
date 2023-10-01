FROM python:3.11.2 

USER root

# 全域設定
WORKDIR /app

# 安裝環境、安裝工具	
RUN apt-get update -y \
	&& apt-get install chromium -y \
	&& apt-get install chromium-driver -y 

RUN apt-get install default-jre -y \
	&& wget https://github.com/allure-framework/allure2/releases/download/2.18.1/allure_2.18.1-1_all.deb \
	&& dpkg -i allure_2.18.1-1_all.deb \
	&& rm allure_2.18.1-1_all.deb \
	&& apt clean && rm -rf /var/lib/apt/lists/*

# 安裝程式依賴套件
COPY requirements.txt ./
RUN pip3 install --upgrade pip \
	&& pip3 install -r requirements.txt

# 程式碼
COPY . .

# change mode, 控制用戶對文件的權限
RUN chmod +x exec_test.sh

CMD ./exec_test.sh