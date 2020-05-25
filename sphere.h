#ifndef SPHERE_H
#define SPHERE_H

#include "hitable.h"

class Sphere : public Hitable
{
public:
    Sphere() {};
    Sphere(vec3 cen, float r) : center(cen), radius(r) {};
    virtual bool Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const override;
    vec3 center;
    float radius;
};

#endif // SPHERE_H
