PLUGINDIR=${PREFIX}/lib/collectd
INCLUDEDIR=/usr/local/include/collectd/ ${EXTRA_INCLUDE} -I${PREFIX}/include/

LFLAGS=-L${PREFIX}/lib/varnish/ -L${PREFIX}/lib -lvarnishapi
CFLAGS=-I${INCLUDEDIR} -Wall -Werror -g -O2 -DHAVE_VARNISH_V3

all:
	${CC} -DHAVE_CONFIG_H ${CFLAGS} -c varnish.c -fPIC -DPIC -o varnish.o
	${CC} ${LFLAGS} -shared varnish.o -Wl,-soname -Wl,varnish.so -o varnish.so

clean:
	rm -f varnish.o varnish.so

install:
	mkdir -p ${DESTDIR}/${PLUGINDIR}/
	cp varnish.so ${DESTDIR}/${PLUGINDIR}/
