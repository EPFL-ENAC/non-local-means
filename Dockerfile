FROM jupyter/minimal-notebook:python-3.8.8

USER root
RUN apt-get update && apt-get install -y \
    libgl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_UID}

COPY requirements.txt environment.yml /tmp/
RUN conda env update -q -f /tmp/environment.yml \
    && /opt/conda/bin/pip install -r /tmp/requirements.txt \
    && conda clean -y --all
