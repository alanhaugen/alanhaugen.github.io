#ifndef CAMERA_H
#define CAMERA_H

#include "ray.h"

class Camera
{
public:
    Camera(vec3 lookFrom, vec3 lookAt, vec3 vup, float vfov, float aspect);
    ray GetRay(float u, float v);

    vec3 origin;
    vec3 lowerLeftCorner;
    vec3 horizontal;
    vec3 vertical;
};

#endif // CAMERA_H
