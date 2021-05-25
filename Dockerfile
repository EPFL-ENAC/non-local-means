# For finding latest versions of the base image see
# https://github.com/SwissDataScienceCenter/renkulab-docker
ARG RENKU_BASE_IMAGE=renku/renkulab-py:3.8-0.7.6
FROM ${RENKU_BASE_IMAGE}

#################################################################
USER root

RUN apt-get update \
    && apt-get install -y -q --no-install-recommends \
        curl \
        dbus-x11 \
        firefox \
        less \
        net-tools \
        xfce4 \
        xfce4-panel \
        xfce4-session \
        xfce4-settings \
        xorg \
        xubuntu-icon-theme \
        xterm \
        openjdk-8-jre \
        openjdk-8-jdk \
        openjfx \
        unzip \
    && apt-get autoremove --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && find /var/log -type f -exec cp /dev/null \{\} \;

#################################################################
RUN cd /opt && \
    curl -sSfL https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -zxf -

# Patch novnc to use correct path to websockify (defaults to /)
# Note if you use vnc.html you will need to patch ui.js to use the correct path
# and also to override localstorage which may store an incorrect path from a
# different session
# Also resize server instead of scaling client
RUN sed -i.bak \
    -e "s%\('path', 'websockify'\)%'path', window.location.pathname.replace(/[^/]*$/, '').substring(1) + 'websockify'); console.log('websockify path:' + path%" \
    -re "s%rfb.scaleViewport = .+%rfb.resizeSession = readQueryVariable('resize', true);%" \
    /opt/noVNC-1.1.0/vnc_lite.html

# Install tigervnc to /usr/local
RUN curl -sSfL 'https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz' | tar -zxf - -C /usr/local --strip=2

#----------------------------------------------------------------
# ImageJ
#----------------------------------------------------------------
RUN wget -q https://downloads.imagej.net/fiji/latest/fiji-linux64.zip \
      && unzip fiji-linux64.zip -d /opt/ \
      && rm fiji-linux64.zip

COPY --chown=1000:100 *.desktop /home/jovyan/Desktop/

#################################################################
# install the jupyter extensions
USER ${NB_USER}

RUN conda install jupyter-server-proxy numpy websockify -c conda-forge \
    && jupyter labextension install @jupyterlab/server-proxy \
    && conda clean -y --all 

COPY jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py

# install the python dependencies
COPY requirements.txt environment.yml /tmp/
RUN conda env update -q -f /tmp/environment.yml && \
    /opt/conda/bin/pip install -r /tmp/requirements.txt && \
    conda clean -y --all && \
    conda env export -n "root"
    
# RENKU_VERSION determines the version of the renku CLI
# that will be used in this image. To find the latest version,
# visit https://pypi.org/project/renku/#history.
ARG RENKU_VERSION=0.14.2

########################################################
# Do not edit this section and do not add anything below

RUN if [ -n "$RENKU_VERSION" ] ; then \
    pipx uninstall renku && \
    pipx install --force renku==${RENKU_VERSION} \
    ; fi

########################################################
