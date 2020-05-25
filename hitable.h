#ifndef HITABLE_H
#define HITABLE_H

#include "ray.h"

struct hitRecord
{
    float t;
    vec3 p;
    vec3 normal;
};

class Hitable
{
public:
    virtual bool Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const = 0;
};

#endif // HITABLE_H
