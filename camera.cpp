#include "camera.h"

Camera::Camera(vec3 lookFrom, vec3 lookAt, vec3 vup, float vfov, float aspect, float aperture, float focusDist)
{
    lensRadius = aperture / 2;
    float theta = vfov * M_PI / 180;
    float halfHeight = tan(theta/2);
    float halfWidth = aspect * halfHeight;

    origin = lookFrom;

    w = unitVector(lookFrom - lookAt);
    u = unitVector(cross(vup, w));
    v = cross(w, u);

    lowerLeftCorner = origin - halfWidth * focusDist * u - halfHeight * focusDist * v - focusDist * w;
    horizontal = 2 * halfWidth * focusDist * u;
    vertical = 2 * halfHeight * focusDist * v;
}

ray Camera::GetRay(float s, float t)
{
    vec3 rd = lensRadius * randomInUnitDisk();
    vec3 offset = u * rd.x() + v * rd.y();
    return ray(origin + offset, lowerLeftCorner + s * horizontal + t * vertical - origin - offset);
}

vec3 randomInUnitDisk()
{
    vec3 p;
    do
    {
        float ran1 = rand() / float(RAND_MAX);
        float ran2 = rand() / float(RAND_MAX);
        p = 2.0 * vec3(ran1, ran2, 0) - vec3(1, 1, 0);
    }
    while(dot(p, p) >= 1.0);

    return p;
}
