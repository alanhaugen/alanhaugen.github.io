#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cfloat>

#include "ray.h"
#include "vec3.h"
#include "sphere.h"
#include "camera.h"
#include "hitablelist.h"
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"

float hitSphere(const vec3 &center, float radius, const ray &r)
{
    vec3 oc = r.origin() - center;

    float a = dot(r.direction(), r.direction());
    float b = 2.0 * dot(oc, r.direction());
    float c = dot(oc, oc) - radius*radius;

    float discriminant = b*b - 4*a*c;

    if (discriminant < 0)
    {
        return -1.0;
    }
    else
    {
        return (-b - sqrt(discriminant)) / (2.0 * a);
    }
}

vec3 color(const ray &r, Hitable *world)
{
    hitRecord rec;

    if (world->Hit(r, 0.0, FLT_MAX, rec))
    {
        return 0.5 * vec3(rec.normal.x() + 1, rec.normal.y() + 1, rec.normal.z() + 1);
    }
    else
    {
        vec3 unitDirection = unitVector(r.direction());
        float t = 0.5 * (unitDirection.y() + 1.0);

        return (1.0 - t) * vec3(1.0, 1.0, 1.0) + t * vec3(0.5, 0.7, 1.0);
    }
}

int main()
{
	int nx = 200;
	int ny = 100;
    int ns = 100;
	int channels = 3;

	uint8_t data[3 * 200 * 100];

    Camera cam;

	vec3 lowerLeftCorner(-2.0, -1.0, -1.0);
	vec3 horizontal(4.0, 0.0, 0.0);
	vec3 vertical(0.0, 2.0, 0.0);
	vec3 origin(0.0, 0.0, 0.0);

    Hitable *list[2];
    list[0] = new Sphere(vec3(0, 0, -1), 0.5);
    list[1] = new Sphere(vec3(0, -100.5, -1), 100);

    Hitable *world = new HitableList(list, 2);

	int index = 0;

	for (int j = ny - 1; j >= 0; j--)
	{
		for (int i = 0; i < nx; i++)
		{
            vec3 col(0.0, 0.0, 0.0);
            for (int s = 0; s < ns; s++)
            {
                float ran = rand() / float(RAND_MAX);
                float u = float(i + ran) / float(nx);
                float v = float(j + ran) / float(ny);

                ray r = cam.GetRay(u, v);

                vec3 p = r.pointAtParameter(2.0);
                col += color(r, world);
            }
            col /= float(ns);

            data[index++] = int(255.99 * col[0]);
            data[index++] = int(255.99 * col[1]);
            data[index++] = int(255.99 * col[2]);
        }
	}

	int success = stbi_write_png("img.png", nx, ny, channels, data, nx * channels);

	return success;
}

