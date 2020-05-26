#ifndef MATERIAL_H
#define MATERIAL_H

#include "ray.h"
#include "hitable.h"

class Material
{
public:
    virtual bool Scatter(const ray &rayIn, const hitRecord &rec, vec3 &attenuation, ray &scattered) const = 0;
};

vec3 Reflect(const vec3 &v, const vec3 &n)
{
    return v - 2*dot(v,n) * n;
}

class Lambertian : public Material
{
public:
    Lambertian(const vec3 &a) : albedo(a) {}
    virtual bool Scatter(const ray &rayIn, const hitRecord &rec, vec3 &attenuation, ray &scattered) const
    {
        vec3 target = rec.p + rec.normal + randomInUnitSphere();
        scattered = ray(rec.p, target-rec.p);
        attenuation = albedo;

        return true;
    }

    vec3 albedo;
};

class Metal : public Material
{
public:
    Metal(const vec3 &a, float f) : albedo(a) {if (f < 1) { fuzz = f;} else { fuzz = 1;}}
    virtual bool Scatter(const ray &rayIn, const hitRecord &rec, vec3 &attenuation, ray &scattered) const
    {
        vec3 reflected = Reflect(unitVector(rayIn.direction()), rec.normal);
        scattered = ray(rec.p, reflected + fuzz * randomInUnitSphere());
        attenuation = albedo;
        return (dot(scattered.direction(), rec.normal) > 0);
    }

    vec3 albedo;
    float fuzz;
};

#endif // MATERIAL_H
