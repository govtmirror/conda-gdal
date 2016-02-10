#!/bin/bash

# http://www.michael-joost.de/gdal_install.html
unset CC CPP CXX

if [ `uname` == Darwin ]; then
    export LDFLAGS="$LDFLAGS -headerpad_max_install_names"
fi

bash configure \
    --with-python \
    --with-hdf4=$PREFIX \
    --with-hdf5=$PREFIX \
    --with-xerces=$PREFIX \
    --with-netcdf=$PREFIX \
    --with-geos=$PREFIX/bin/geos-config \
    --with-kea=$PREFIX/bin/kea-config \
    --with-spatialite \
    --prefix=$PREFIX
make
make install

# Make sure GDAL_DATA and set and still present in the package
# https://github.com/conda/conda-recipes/pull/267
ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/gdal-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/gdal-deactivate.sh


