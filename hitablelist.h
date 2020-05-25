#ifndef HITABLELIST_H
#define HITABLELIST_H

#include "hitable.h"

class HitableList : public Hitable
{
public:
    HitableList() {};
    HitableList(Hitable **l, int n) {list = l; listSize = n; }
    virtual bool Hit(const ray &r, float tMin, float tMax, hitRecord &rec) const override;
    Hitable **list;
    int listSize;
};

#endif // HITABLELIST_H
