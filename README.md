# my-haskell-lambda

```
make
cp $(stack --docker path --local-install-root)/bin/bootstrap build
cd build && zip function.zip bootstrap && rm bootstrap && cd ..
```
