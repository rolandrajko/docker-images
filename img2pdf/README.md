# img2pdf Docker image
[img2pdf](https://gitlab.mister-muffin.de/josch/img2pdf) is a tool to lossless conversion of raster images to PDF.

## Usage
```
docker run --rm -it -v $PWD:/app -w /app rolandrajko/img2pdf -o images.pdf img1.png img2.jpg
```
