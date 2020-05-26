## Specific version as tag instead of "latest" for reproducibility
FROM rocker/binder:3.6.3

## Declares build arguments
ARG NB_USER
ARG NB_UID

## Install some TexLive packages
USER root
RUN tlmgr install beamer beamertheme-metropolis collection-latex mathspec oberdiek pgfopts translator
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

## Become normal user again
USER ${NB_USER}

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi
