#include <iostream>
#include <stdio.h>
#include <stdlib.h>

//#include "ray.h"
#include "vec3.h"
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
            vec3 col(float(i) / float(nx), float(j) / float(ny), 0.2);

            data[index++] = int(255.99 * col[0]);
            data[index++] = int(255.99 * col[1]);
            data[index++] = int(255.99 * col[2]);
		}
	}

    int success = stbi_write_png("img.png", nx, ny, channels, data, nx * channels);

    return success;

	//vec3 lowerLeftCorner(-2.0, -1.0, -1.0);
}

