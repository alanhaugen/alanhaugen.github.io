OBJS = ray.o
.PHONY: clean 

pathtracer: $(OBJS)
	g++ $(OBJS) -o raytracer

%.o: %.cpp
	g++ -c $*.cpp

clean:
	rm *.o
