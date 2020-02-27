FROM jenkins/jnlp-agent-alpine

WORKDIR /usr/src/app

ENV PYTHONUNBUFFERED=1

# Adjust the following ENV values for your Jenkins host, and port
ENV JENKINS_URL=http://192.168.1.241:10010
ENV JENKINS_TUNNEL=192.168.1.241:10000

COPY requirements.txt .

RUN apk add python3 python3-dev build-base linux-headers pcre-dev
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt

ENV PATH "$PATH:/usr/src/app"
