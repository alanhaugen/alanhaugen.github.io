OBJS = ray.o
.PHONY: clean all

all: pathtracer

pathtracer: $(OBJS)
	g++ $(OBJS) -o pathtracer

%.o: %.cpp
	g++ -c $*.cpp

clean:
	rm *.o img.png
