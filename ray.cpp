#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cfloat>

#include "ray.h"
#include "vec3.h"
#include "sphere.h"
#include "camera.h"
#include "material.h"
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

vec3 randomInUnitSphere() // Muller 1959, Marsaglia 1972 https://mathworld.wolfram.com/SpherePointPicking.html
{
    float x,y,z;
    x = rand() / float(RAND_MAX);
    y = rand() / float(RAND_MAX);
    z = rand() / float(RAND_MAX);

    vec3 point(x, y, z);
    x *= 1 / point.length();
    y *= 1 / point.length();
    z *= 1 / point.length();

    return vec3(x, y, z);
}

vec3 color(const ray &r, Hitable *world, int depth)
{
    hitRecord rec;

    if (world->Hit(r, 0.001, FLT_MAX, rec))
    {
        ray scattered;
        vec3 attenuation;

        if (depth < 50 && rec.matPtr->Scatter(r, rec, attenuation, scattered))
        {
            return attenuation*color(scattered, world, depth + 1);
        }
        else
        {
            return vec3(0, 0, 0);
        }
    }
    else
    {
        vec3 unitDirection = unitVector(r.direction());
        float t = 0.5 * (unitDirection.y() + 1.0);

        return (1.0 - t) * vec3(1.0, 1.0, 1.0) + t * vec3(0.5, 0.7, 1.0);
    }
}

float ran()
{
    return rand() / float(RAND_MAX);
}

Hitable *randomScene()
{
    int n = 500;
    Hitable **list = new Hitable*[n+1];
    list[0] = new Sphere(vec3(0, -1000, 0), 1000, new Lambertian(vec3(0.5, 0.5, 0.5)));
    int i = 1;
    for (int a = -11; a < 11; a++)
    {
        for (int b = -11; b < 11; b++)
        {
            float chooseMat = ran();
            vec3 center(a + 0.9 * ran(), 0.2, b + 0.9 * ran());

            if ((center - vec3(4, 0.2, 0)).length() > 0.9)
            {
                if (chooseMat < 0.8) // diffuse
                {
                    list[i++] = new Sphere(center, 0.2, new Lambertian(vec3(ran()*ran(), ran()*ran(), ran()*ran())));
                }
                else if (chooseMat < 0.95) // metal
                {
                    list[i++] = new Sphere(center, 0.2,
                                           new Metal(vec3(0.5*(1 + ran()), 0.5 * (1 + ran()), 0.5 * ran()), 0.5 * ran()));
                }
                else // glass
                {
                    list[i++] = new Sphere(center, 0.2, new Dielectric(1.5));
                }
            }
        }
    }

    list[i++] = new Sphere(vec3(0, 1, 0), 1.0, new Dielectric(1.5));
    list[i++] = new Sphere(vec3(-4, 1, 0), 1.0, new Lambertian(vec3(0.4, 0.2, 0.1)));
    list[i++] = new Sphere(vec3(4, 1, 0), 1.0, new Metal(vec3(0.7, 0.6, 0.5), 0.0));

    return new HitableList(list, i);
}

int main()
{
	int nx = 200;
	int ny = 100;
    int ns = 100;
	int channels = 3;

	uint8_t data[3 * 200 * 100];

    vec3 lookFrom(3, 3, 2);
    vec3 lookAt(0, 0, -10);
    float distToFocus = (lookFrom - lookAt).length();
    float aperture = 2.0;

    Camera cam(lookFrom, lookAt, vec3(0, 1, 0), 20, float(nx)/float(ny), aperture, distToFocus);

	vec3 lowerLeftCorner(-2.0, -1.0, -1.0);
	vec3 horizontal(4.0, 0.0, 0.0);
	vec3 vertical(0.0, 2.0, 0.0);
	vec3 origin(0.0, 0.0, 0.0);

    /*Hitable *list[5];
    list[0] = new Sphere(vec3(0, 0, -1), 0.5, new Lambertian(vec3(0.1, 0.2, 0.5)));
    list[1] = new Sphere(vec3(0, -100.5, -1), 100, new Lambertian(vec3(0.8, 0.8, 0.0)));
    list[2] = new Sphere(vec3(1, 0, -1), 0.5, new Metal(vec3(0.8, 0.6, 0.2)));
    list[3] = new Sphere(vec3(-1, 0, -1), 0.5, new Dielectric(1.5));
    list[4] = new Sphere(vec3(-1, 0, -1), -0.45, new Dielectric(1.5));

    Hitable *world = new HitableList(list, 5);*/

    Hitable *world = randomScene();

	int index = 0;

	for (int j = ny - 1; j >= 0; j--)
	{
		for (int i = 0; i < nx; i++)
		{
            vec3 col(0.0, 0.0, 0.0);
            for (int s = 0; s < ns; s++)
            {
                float u = float(i + ran()) / float(nx);
                float v = float(j + ran()) / float(ny);

                ray r = cam.GetRay(u, v);

                col += color(r, world, 0);
            }
            col /= float(ns);
            col = vec3(sqrt(col[0]), sqrt(col[1]), sqrt(col[2]));

            data[index++] = int(255.99 * col[0]);
            data[index++] = int(255.99 * col[1]);
            data[index++] = int(255.99 * col[2]);
        }
	}

    int success = stbi_write_png("images/img.png", nx, ny, channels, data, nx * channels);

	return success;
}

