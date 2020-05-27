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

bool Refract(const vec3 &v, const vec3 &n, float niOverNt, vec3 &refracted)
{
    vec3 uv = unitVector(v);
    float dt = dot(uv, n);
    float discriminant = 1.0 - niOverNt * niOverNt * (1 - dt * dt);

    if (discriminant > 0)
    {
        refracted = niOverNt * (uv - n*dt) - n * sqrt(discriminant);
        return true;
    }
    else
    {
        return false;
    }
}

float Schlick(float cosine, float refIdx)
{
    float r0 = (1-refIdx) / (1+refIdx);
    r0 = r0*r0;

    return r0 + (1-r0) * pow((1-cosine), 5);
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
    Metal(const vec3 &a, float f = 0.3) : albedo(a) {if (f < 1) { fuzz = f;} else { fuzz = 1;}}
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

class Dialectric : public Material
{
public:
    Dialectric(float ri) : refIdx(ri) {}
    virtual bool Scatter(const ray &rayIn, const hitRecord &rec, vec3 &attenuation, ray &scattered) const
    {
        vec3 outwardNormal;
        vec3 reflected = Reflect(rayIn.direction(), rec.normal);
        float niOverNt;
        float reflectProb;
        attenuation = vec3(1.0, 1.0, 1.0);
        vec3 refracted;
        float cosine;
        if (dot(rayIn.direction(), rec.normal) > 0)
        {
            outwardNormal = -rec.normal;
            niOverNt = refIdx;
            cosine = refIdx * dot(rayIn.direction(), rec.normal) / rayIn.direction().length();
        }
        else
        {
            outwardNormal = rec.normal;
            niOverNt = 1.0 / refIdx;
            cosine = -dot(rayIn.direction(), rec.normal) / rayIn.direction().length();
        }
        if (Refract(rayIn.direction(), outwardNormal, niOverNt, refracted))
        {
            reflectProb = Schlick(cosine, refIdx);
        }
        else
        {
            scattered = ray(rec.p, reflected);
            reflectProb = 1.0;
        }
        float ran = rand() / float(RAND_MAX);
        if (ran < reflectProb)
        {
            scattered = ray(rec.p, reflected);
        }
        else
        {
            scattered = ray(rec.p, refracted);
        }

        return true;
    }

    float refIdx;
};

#endif // MATERIAL_H
