#ifndef CAMERA_H
#define CAMERA_H

#include "ray.h"

class Camera
{
public:
    Camera();
    ray GetRay(float u, float v);

    vec3 origin;
    vec3 lowerLeftCorner;
    vec3 horizontal;
    vec3 vertical;
};

#endif // CAMERA_H
