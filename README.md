# code2pdf

This image executes a Rust [code2pdf](https://github.com/Tommypop2/code-to-pdf) based that outputs a PDF with 
all source code located at `/code` at the container (exposed using volume).

## How to use

Execute docker image informing the source code at `/code`, the output PDF will be `_.pdf`.

```bash
docker run --rm -v $PWD:/code kelsoncm/code2pdf
```

