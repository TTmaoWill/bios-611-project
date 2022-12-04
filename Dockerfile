FROM rocker/verse
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y python3-pip
RUN pip3 install tensorflow pandas plotnine scikit-learn
RUN Rscript --no-restore --no-save -e "install.packages('reticulate')"
RUN Rscript --no-restore --no-save -e "install.packages('gbm')"
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"