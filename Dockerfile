FROM jupyterhub/jupyterhub

# software-properties-common

RUN apt update && \
    apt-get install -y python3 python3-pip git nano && \
    apt-get install openjdk-8-jdk-headless -qq && \
    git -C /home clone https://github.com/jupyterhub/nativeauthenticator.git && \
    pip3 install -e /home/nativeauthenticator/

RUN python3 -m pip install jupyterhub notebook jupyterlab pandas pyspark apache-airflow

WORKDIR /etc/jupyterhub
COPY custom_config.py .
RUN jupyterhub --generate-config && \
    cat custom_config.py > jupyterhub_config.py

ENTRYPOINT [ "jupyterhub" ]
CMD [ "-f", "jupyterhub_config.py" ]
