example.deb: debian-binary control.tar.gz data.tar.gz
	ar -q example.deb debian-binary control.tar.gz data.tar.gz

debian-binary:
	echo '2.0' > debian-binary

control.tar.gz: md5sums control
	tar czf control.tar.gz md5sums control

data.tar.gz: tmp/empty
	tar czf data.tar.gz tmp/empty

md5sums: tmp/empty
	md5sum tmp/empty > md5sums

# Note: Maintainer and Description needed to avoid warning from dpkg -L
control:
	printf "Package: example\nVersion: 1\nArchitecture: amd64\nMaintainer: irrelevant\nDescription: irrelevant\n" > control

tmp/empty: tmp
	touch tmp/empty

tmp:
	mkdir tmp

.PHONY: clean
clean:
	rm -r debian-binary control.tar.gz data.tar.gz control md5sums tmp/empty tmp example.deb
