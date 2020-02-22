FROM jenkins/jnlp-agent-alpine

WORKDIR /usr/src/app

ENV PYTHONUNBUFFERED=1
ENV JENKINS_URL=http://192.168.1.241:10010
ENV JENKINS_TUNNEL=192.168.1.241:10000

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install pipenv

COPY Pipfile .

ENV PATH "$PATH:/usr/src/app"

RUN set -ex && pipenv lock && pipenv install -d --deploy --system
