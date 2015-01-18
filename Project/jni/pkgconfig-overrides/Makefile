
pkgconfig_dir := ${prefix}/lib/pkgconfig

all: libssl.pc libcrypto.pc

clean:
	rm libssl.pc libcrypto.pc

%.pc : %.pc.in
	sed 's#@prefix@#${prefix}#' libssl.pc.in > $@
	@test -e ${pkgconfig_dir} || mkdir -p ${pkgconfig_dir}
	cp $@ ${pkgconfig_dir}/.
