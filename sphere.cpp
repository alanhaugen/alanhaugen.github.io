#include "sphere.h"

bool Sphere::Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const
{
    vec3 oc = r.origin() - center;
    float a = dot(r.direction(), r.direction());
    float b = dot(oc, r.direction());
    float c = dot(oc, oc) - radius*radius;
    float discriminant = b*b -a*c;

    if (discriminant > 0)
    {
        float temp = (-b - sqrt(b*b-a*c))/a;

        if (temp < tMax && temp > tMin)
        {
            rec.t = temp;
            rec.p = r.pointAtParameter(rec.t);
            rec.normal = (rec.p - center) / radius;

            return true;
        }

        temp = (-b + sqrt(b*b - a*c))/a;

        if (temp < tMax && temp > tMin)
        {
            rec.t = temp;
            rec.p = r.pointAtParameter(rec.t);
            rec.normal = (rec.p - center) / radius;

            return true;
        }
    }

    return false;
}
