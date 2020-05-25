OBJS = ray.o sphere.o hitablelist.o
.PHONY: clean all

all: pathtracer

pathtracer: $(OBJS)
	g++ $(OBJS) -o pathtracer

%.o: %.cpp
	g++ -c $*.cpp

clean:
	rm *.o img.png
