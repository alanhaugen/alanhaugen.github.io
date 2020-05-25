#include "hitablelist.h"

bool HitableList::Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const
{
    hitRecord temp_rec;
    bool hitAnything = false;
    double closestSoFar = tMax;
    for(int i = 0; i < listSize; i++)
    {
        if (list[i]->Hit(r, tMin, closestSoFar, temp_rec))
        {
            hitAnything = true;
            closestSoFar = temp_rec.t;
            rec = temp_rec;
        }
    }

    return hitAnything;
}
