#ifndef ANIMATOR_COMMON_INCLUDED
#define ANIMATOR_COMMON_INCLUDED

#define USE_TIMELINE                0x00000001
#define REMOVE_ROOT_MATRIX          0x00000002
#define DIRECT_POSE_CONTROL         0x00000004

static const uint ANIM_TYPE_NONE                      = 0x0ffffff0;
static const uint ANIM_TYPE_ANIMATION                 = 0x0ffffff1;
static const uint ANIM_TYPE_BLEND_SPACE_1D            = 0x0ffffff2;
static const uint ANIM_TYPE_BLEND_SPACE_2D            = 0x0ffffff3;

struct ShaderAnimation
{
    int     _animation_id;
    int     _blendspace_id;
    int     _buffer_shift;
    int     _num_points;
    float3	_start_time_duration_end;
    float3  _loop; 
    float2  _blend_ratio;
    float3  _transition_params;
    float2  _override_animation;
    int     _arg_number;
};

struct InstanceData
{
    int    _instance_id;
    int3   _livery_id;
    int    _flags;
    int    _animations_stack[MAX_ANIMATIONS_STACK_SIZE];
    int    _stack_size;
    float2 _timeline_params;
    int    _pose_offset;
	float  _args[MAX_ARGUMENTS_SIZE];
    int    _compute_type;
};

bool check_flag(int var, int value)
{
    return (var & value) > 0;
}


float model_time;
static const float4 ONE = float4(1, 1, 1, 1);
#ifndef __cplusplus
#define M_PI 3.141592653589793238462643383279 
#endif
#define REMOVE_ROOT_MOTION

float3x3 quat_to_mattrix(float x, float y, float z, float w)
{
    float3x3 resMatrix;
    resMatrix[0][0] = 1.0 - 2.0 * (y * y + z * z);
    resMatrix[0][1] = 2.0 * (x * y - z * w);
    resMatrix[0][2] = 2.0 * (x * z + y * w);
    resMatrix[1][0] = 2.0 * (x * y + z * w);
    resMatrix[1][1] = 1.0 - 2.0 * (x * x + z * z);
    resMatrix[1][2] = 2.0 * (y * z - x * w);
    resMatrix[2][0] = 2.0 * (x * z - y * w);
    resMatrix[2][1] = 2.0 * (y * z + x * w);
    resMatrix[2][2] = 1.0 - 2.0 * (x * x + y * y);
    return resMatrix;
}
float4x4 make_matrix( float4 rotation, float4 position)
{
    float4x4 res;
 
    float3x3 m = quat_to_mattrix(rotation.x, rotation.y, rotation.z, rotation.w);

    res[0][0] = m[0][0];
    res[0][1] = m[0][1];
    res[0][2] = m[0][2];
    res[0][3] = position.x;

    res[1][0] = m[1][0];
    res[1][1] = m[1][1];
    res[1][2] = m[1][2];
    res[1][3] = position.y;

    res[2][0] = m[2][0];
    res[2][1] = m[2][1];
    res[2][2] = m[2][2];
    res[2][3] = position.z;

    res[3][0] = 0.0;
    res[3][1] = 0.0;
    res[3][2] = 0.0;
    res[3][3] = 1.0;
    
    return transpose(res);
}


float3 to_eulerian_angle(float4 quat)
{
    float yaw = 0;
    float pitch = 0;
    // roll (x-axis rotation)
    float sinr = +2.0 * (quat.w * quat.x + quat.y * quat.z);
    float cosr = +1.0 - 2.0 * (quat.x * quat.x + quat.y * quat.y);
    float roll = atan2(sinr, cosr);

    // pitch (y-axis rotation)
    float sinp = +2.0 * (quat.w * quat.y - quat.z * quat.x);
    if (abs(sinp) >= 1)
        pitch = M_PI / 2 *sign( sinp); // use 90 degrees if out of range
    else
        pitch = asin(sinp);

    // yaw (z-axis rotation)
    float siny = +2.0 * (quat.w * quat.z + quat.x * quat.y);
    float cosy = +1.0 - 2.0 * (quat.y * quat.y + quat.z * quat.z);
    yaw = atan2(siny, cosy);
    float pitch_ = yaw;
    float yaw_ = pitch;
    return float3(yaw_, pitch_, roll);
}

float4 to_quaternion(float3 angles)
{
    float yaw = angles.y;
    float pitch = angles.x;
    float roll = angles.z;
    float4 q;
    // Abbreviations for the various angular functions
    float cy = cos(yaw * 0.5);
    float sy = sin(yaw * 0.5);
    float cr = cos(roll * 0.5);
    float sr = sin(roll * 0.5);
    float cp = cos(pitch * 0.5);
    float sp = sin(pitch * 0.5);

    q.w = cy * cr * cp + sy * sr * sp;
    q.x = cy * sr * cp - sy * cr * sp;
    q.y = cy * cr * sp + sy * sr * cp;
    q.z = sy * cr * cp - cy * sr * sp;
    return q;
}

float4 interpolate_quat( float4 pStart, float4 pEnd, float pFactor)
{
    float4 pOut;
    // calc cosine theta
    float cosom = pStart.x * pEnd.x + pStart.y * pEnd.y + pStart.z * pEnd.z + pStart.w * pEnd.w;

    // adjust signs (if necessary)
    float4 end = pEnd;
    if( cosom < 0.0)
    {
        cosom = -cosom;
        end.x = -end.x;   // Reverse all signs
        end.y = -end.y;
        end.z = -end.z;
        end.w = -end.w;
    }

    // Calculate coefficients
    float sclp, sclq;
    if( (1.0 - cosom) > 0.0001) // 0.0001 -> some epsillon
    {
        // Standard case (slerp)
        float omega, sinom;
        omega = acos( cosom); // extract theta from dot product's cos theta
        sinom = sin( omega);
        sclp  = sin( (1.0 - pFactor) * omega) / sinom;
        sclq  = sin( pFactor * omega) / sinom;
    } 
    else
    {
        // Very close, do linear interp (because it's faster)
        sclp = 1.0 - pFactor;
        sclq = pFactor;
    }

    pOut.x = sclp * pStart.x + sclq * end.x;
    pOut.y = sclp * pStart.y + sclq * end.y;
    pOut.z = sclp * pStart.z + sclq * end.z;
    pOut.w = sclp * pStart.w + sclq * end.w;
    return pOut;
}

#endif