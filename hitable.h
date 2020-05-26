#ifndef HITABLE_H
#define HITABLE_H

#include "ray.h"

class Material;

struct hitRecord
{
    float t;
    vec3 p;
    vec3 normal;
    Material *matPtr;
};

class Hitable
{
public:
    virtual bool Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const = 0;
};

#endif // HITABLE_H
