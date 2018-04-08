# Share-blade

This project collects scripts for image splitting from given scanned one
with/without text.

# Requirements

- bash
- imagemagick

# Usage

```
./simple.sh 
# will try to load local image.png by default
# output files will be save to folder/cropped/*.png
```

```
./glob.sh pattern
# will try to load input glob patterns and feed to ./simple.sh
```

# Todos

- auto deskew
- auto rotate to reasonable view

# Credits

- https://stackoverflow.com/a/48558406/3672225

