FROM i386/ubuntu

RUN apt update && apt install -y \
    apt-transport-https \
    curl lsb-release wget \
    vim iproute2 nano \
    iputils-ping unzip

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt-get -y install terraform
RUN curl https://sdk.cloud.google.com | bash

WORKDIR /app

ENV PATH=/root/google-cloud-sdk/bin/:$PATH

CMD ["sleep", "infinite"]


