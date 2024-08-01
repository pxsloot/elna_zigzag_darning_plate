.PHONY: all clean

objects = elna_zigzag_darning_plate.png elna_zigzag_darning_plate.stl

all: $(objects)

# $(objects): %.stl: %.scad

clean:
	rm -f *.stl *.png

%.png: %.scad
	openscad -o $@ $<
%.stl: %.scad
	openscad -o $@ $<
