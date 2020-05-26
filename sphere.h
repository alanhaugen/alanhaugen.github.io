#ifndef SPHERE_H
#define SPHERE_H

#include "hitable.h"

class Sphere : public Hitable
{
public:
    Sphere() {};
    Sphere(vec3 cen, float r, Material *m) : center(cen), radius(r), matPtr(m) {};
    virtual bool Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const override;
    vec3 center;
    float radius;
    Material *matPtr;
};

#endif // SPHERE_H
