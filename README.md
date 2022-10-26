Getting Started
===============

Build the docker image by typing:
```
docker build . -t chenweit611
```

And then start an RStudio by typing:

```
docker run -v $(pwd):/home/rstudio/proj -p 8787:8787 -e PASSWORD=<some-password> -it chenweit611
```

Once the Rstudio is running connect to it by visiting
https://localhost:8787 in your browser. 

To build the final report, visit the terminal in RStudio and type

```
make report.pdf
```

Alternatively run codes in Rstudio:
```
docker run -v $(pwd):/home/rstudio/proj\
       --user="rstudio" --workdir="/home/rstudio/proj" -t chenweit611\
       make report.pdf
```