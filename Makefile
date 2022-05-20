SHELL  := /bin/bash

RDF    = rdf
RAPPER = rapper
DOT    = dot
PANDOC = pandoc
RSYNC  = rsync
ME     = loupe
SITE   = doriantaylor.com:ms/vocab/

target: variants readme # dot

variants:
	$(RDF) serialize --input-format=rdfa --output-format=turtle -o $(ME).ttl $(ME).xml
	$(RAPPER) -i turtle -o rdfxml $(ME).ttl > $(ME).rdf

# dot:
# 	for i in $(ME)*.dot ; do $(DOT) -Tsvg -o `echo $$i | sed 's/dot$$/svg/'` $$i ; $(DOT) -Tpng -o `echo $$i | sed 's/dot$$/png/'` $$i ; done

readme:
	$(PANDOC) -f html -t gfm $(ME).xml > README.md

push:
	rsync -avz --progress $(ME)* $(SITE)

clean:
	rm -f $(ME)*.{rdf,ttl,svg,png}
