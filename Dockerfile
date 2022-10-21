FROM rocker/verse
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y python3-pip
RUN pip3 install tensorflow pandas plotnine
RUN Rscript --no-restore --no-save -e "install.packages('reticulate')"