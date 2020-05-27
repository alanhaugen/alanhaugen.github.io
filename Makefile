OBJS = ray.o sphere.o hitablelist.o camera.o
HEADERS = material.h hitablelist.h ray.h camera.h hitable.h sphere.h vec3.h
.PHONY: clean all

all: pathtracer

pathtracer: $(OBJS) $(HEADERS)
	g++ $(OBJS) -o pathtracer

%.o: %.cpp
	g++ -g -c $*.cpp

clean:
	rm *.o img.png
