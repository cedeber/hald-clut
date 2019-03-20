# Needs ImageMagick + OptiPNG

# Generate an identity 12-level 16-bit HaldCLUT image using ImageMagick
# convert hald:12 -depth 16 -colorspace sRGB hald12_16bit.tif

# Convert original HaldCLUT to smaller HaldCLUT in order to use them in web applications.
IFS=$'\n'
for file in $(find HaldClut -name \*.png -type f); do
    dir=$(dirname $(echo $file | cut -d'/' -f2-))
    filename=$(basename $file)
    out=$(echo "out/$dir/$filename" | tr " " "_" | tr "[:upper:]" "[:lower:]")

    echo "$dir : $filename\\n=> $out\\n"

    mkdir -p $(dirname $out)
    convert hald:8 -depth 8 -colorspace sRGB $file -hald-clut $out
    optipng -o1 -silent $out
done
