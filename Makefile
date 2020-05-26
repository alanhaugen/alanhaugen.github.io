OBJS = ray.o sphere.o hitablelist.o camera.o
.PHONY: clean all

all: pathtracer

pathtracer: $(OBJS)
	g++ $(OBJS) -o pathtracer

%.o: %.cpp
	g++ -g -c $*.cpp

clean:
	rm *.o img.png
