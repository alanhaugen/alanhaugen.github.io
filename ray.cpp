#include <iostream>
//#include "ray.h"

/*
vec3 color(const ray &r)
{
	vec3 unitDirection = unitVector(r.direction());
	float t = 0.5 * (unitDirection.y() + 1.0);

	return (1.0 - t) * vec3(1.0, 1.0, 1.0) + t * vec3(0.5, 0.7, 1.0);
}
*/

int main()
{
	int nx = 200;
	int ny = 100;

	std::cout << "P3\n" << nx << " " << ny << "\n255\n";

	for (int j = ny - 1; j >= 0; j--)
	{
		for (int i = 0; i < nx; i++)
		{
			float r = float(i) / float(nx);
			float g = float(j) / float(ny);
			float b = 0.2;

			int ir = int(255.99 * r);
			int ig = int(255.99 * g);
			int ib = int(255.99 * b);

			std::cout << ir << " " << ig << " " << ib << "\n";
		}
	}

	//vec3 lowerLeftCorner(-2.0, -1.0, -1.0);
}

