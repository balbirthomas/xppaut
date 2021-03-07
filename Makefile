# Copyright (C) 1990-2016 Bard Ermentrout & Daniel Dougherty & Robert McDougal
# Edited for Debian GNU/Linux.
DESTDIR = /usr/local
BINDIR = $(DESTDIR)/bin
DOCDIR = $(DESTDIR)/share/doc/xppaut
MANDIR = $(DESTDIR)/man/man1

VERSION=8.0
MAJORVER=8.0
MINORVER=0

ODES=ode/*.ode ode/*.ani canonical/*.* tstauto/*.ode
DOC=docs/xpp_doc.pdf docs/xpp_sum.pdf docs/install.pdf docs/tree.pdf
HELP=help/*.html

# Use c99 to compile according to newer ISO C standards (IEEE Std 1003.1-2001)
CC= gcc -std=c99 -pedantic -D_XOPEN_SOURCE=600 -Wall

################################## 
# Standard Linux distributions   #
##################################
CFLAGS= -g -pedantic -O2 -DNOERRNO -DNON_UNIX_STDIO -DAUTO -DCVODE_YES  -DHAVEDLL -DMYSTR1=$(MAJORVER) -DMYSTR2=$(MINORVER) -Iinclude -Isrc/bitmaps -I.
LDFLAGS= -L/usr/X11/lib
LIBS= -lX11 -lm -ldl

###############################################################  
#     You  can stop messing with it now, the rest is
#     probably OkeyDokey
###############################################################
HEADERS= $(wildcard include/*.h)
SOURCES= $(wildcard src/*.c)
BITMAPS= $(wildcard src/bitmaps/*.bitmap)
OBJECTS= $(patsubst %.c,%.o, $(SOURCES))

######################################################################

xppaut: $(OBJECTS)
	 $(CC) -DAUTO -o xppaut $(OBJECTS) $(LDFLAGS) $(LIBS) 

####################################################
#  tar file
####################################################
tarfile:
	tar zcvf xppaut$(VERSION).tgz --transform "s/^/xppaut-$(VERSION)\//" \
	betty bin bitmaps canonical changes.txt cuda docs help HISTORY \
	include *.html LICENSE Makefile makefiles man ode README* \
	sbml src style tstauto

#######################################################################
# Edited for Debian GNU/Linux.
#######################################################################
install: xppaut 
# Make necessary installation directories
	mkdir -p $(DESTDIR)/$(BINDIR)
	mkdir -p $(DESTDIR)/$(DOCDIR)/html
	mkdir -p $(DESTDIR)/$(DOCDIR)/examples
	mkdir -p $(DESTDIR)/$(DOCDIR)/xbm
	mkdir -p $(DESTDIR)/$(MANDIR)
# Put everything home
	strip xppaut
	install -m 755 xppaut $(DESTDIR)/$(BINDIR)
	cp -r ode* $(DESTDIR)/$(DOCDIR)/examples
	cp -r help/* $(DESTDIR)/$(DOCDIR)/html
	cp README docs/*.pdf $(DESTDIR)/$(DOCDIR)
	cp bitmaps/*.xbm $(DESTDIR)/$(DOCDIR)/xbm 
	cp man/xppaut.1 $(DESTDIR)/$(MANDIR)
# End Debian Ed

uninstall: 
# Remove everything you created
	rm $(DESTDIR)/$(BINDIR)/xppaut
	rm -r $(DESTDIR)/$(DOCDIR)
	rm -r $(DESTDIR)/$(MANDIR)/xppaut.1
# End Debian Ed

##############################################
#  pack up a binary
##############################################
binary:
	tar zvcf binary.tgz --transform "s/^/xppaut-$(VERSION)\//" \
		xppaut bitmaps/*.xbm man/xppaut.1 canonical/* \
		$(ODES) $(DOC) $(HELP) README HISTORY LICENSE

##############################################
#  clean
##############################################
clean:
	$(RM) -f $(OBJECTS) xppaut
	cd docs && make clean && cd ..

#######################################################
#  Documentation
#######################################################
xppdoc:     
	cd docs && make docs
