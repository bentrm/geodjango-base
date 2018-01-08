FROM python:3.6-alpine

RUN apk add --no-cache bash build-base gcc abuild binutils cmake linux-headers

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
  && ./configure && ./mkbindist.sh 2.2.1 linux \
  && cd / && rm -Rf /gdal-2.2.1 /gdal221.zip
