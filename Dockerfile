FROM python:3.6-alpine

RUN apk add --no-cache  --virtual .build-deps build-base gcc abuild binutils cmake linux-headers

ADD http://download.osgeo.org/geos/geos-3.5.1.tar.bz2 /
RUN tar xjf /geos-3.5.1.tar.bz2 \
  && cd /geos-3.5.1 \
  && ./configure && make && make install \
  && cd / \
  && rm -Rf /geos-3.5.1 /geos-3.5.1.tar.bz2

ADD http://download.osgeo.org/proj/proj-4.9.3.tar.gz /
ADD http://download.osgeo.org/proj/proj-datumgrid-1.5.tar.gz /
RUN tar xzf /proj-4.9.3.tar.gz \
  && cd /proj-4.9.3/nad \
  && tar xzf /proj-datumgrid-1.5.tar.gz \
  && cd ../ \
  && ./configure && make && make install \
  && cd / && rm -Rf /proj-4.9.3 /proj-4.9.3.tar.gz proj-datumgrid-1.5.tar.gz

ADD http://download.osgeo.org/gdal/2.2.1/gdal221.zip /
RUN unzip /gdal221.zip \
  && cd /gdal-2.2.1 \
  && ./configure \
    --with-geos \
    --with-geotiff=internal \
    --with-hide-internal-symbols \
    --with-libtiff=internal \
    --with-libz=internal \
    --with-threads \
    --without-bsb \
    --without-cfitsio \
    --without-cryptopp \
    --without-curl \
    --without-dwgdirect \
    --without-ecw \
    --without-expat \
    --without-fme \
    --without-freexl \
    --without-gif \
    --without-gif \
    --without-gnm \
    --without-grass \
    --without-grib \
    --without-hdf4 \
    --without-hdf5 \
    --without-idb \
    --without-ingres \
    --without-jasper \
    --without-jp2mrsid \
    --without-jpeg \
    --without-kakadu \
    --without-libgrass \
    --without-libkml \
    --without-libtool \
    --without-mrf \
    --without-mrsid \
    --without-mysql \
    --without-netcdf \
    --without-odbc \
    --without-ogdi \
    --without-openjpeg \
    --without-pcidsk \
    --without-pcraster \
    --without-pcre \
    --without-perl \
    --without-pg \
    --without-php \
    --without-png \
    --without-python \
    --without-qhull \
    --without-sde \
    --without-sqlite3 \
    --without-webp \
    --without-xerces \
    --without-xml2 \
  && make && make install \
  && cd / && rm -Rf /gdal-2.2.1 /gdal221.zip

RUN apk del .build-deps
