#include <iostream>
#include <stdio.h>
#include <stdlib.h>

//#include "ray.h"
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"

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
    int channels = 3;

    uint8_t data[3 * 200 * 100];

    int index = 0;

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

            data[index++] = ir;
            data[index++] = ig;
            data[index++] = ib;
		}
	}

    int success = stbi_write_png("img.png", nx, ny, channels, data, nx * channels);

    return success;

	//vec3 lowerLeftCorner(-2.0, -1.0, -1.0);
}

