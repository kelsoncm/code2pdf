# code2pdf

This image (thanks to [@sedir](https://github.com/sedir)) executes a code2pdf ruby based (thanks to [@lucascaton](https://github.com/lucascaton)) that outputs a PDF with all source code localated at `/code` at the container (exposed using volume).


## How to use

Execute docker image informing the source code at `/code`, the output PDF will be `_.pdf`.

```bash
docker run --rm -v $PWD:/code kelsoncm/code2pdf .
```

You can ignore files to output putting a file named `.code2pdf` as specified here https://github.com/lucascaton/code2pdf#blacklist-file-example .