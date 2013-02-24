dofile("Vec3.lua")

-- DEBUG
-- local v1, v2, v3

-- Constructors

v1 = Vec3.new()
assert(0.0 == v1.x)
assert(0.0 == v1.y)
assert(0.0 == v1.z)

v1 = Vec3.new_copy({})
assert(0.0 == v1.x)
assert(0.0 == v1.y)
assert(0.0 == v1.z)

v1 = Vec3()
assert(0.0 == v1.x)
assert(0.0 == v1.y)
assert(0.0 == v1.z)

v1 = Vec3.new(1.0, 2.0, 3.0)
assert(1.0 == v1.x)
assert(2.0 == v1.y)
assert(3.0 == v1.z)

v1 = Vec3(4.0, 5.0, 6.0)
assert(4.0 == v1.x)
assert(5.0 == v1.y)
assert(6.0 == v1.z)

v1 = Vec3.new_copy({ x = 7.0, y = 8.0, z = 9.0 })
assert(7.0 == v1.x)
assert(8.0 == v1.y)
assert(9.0 == v1.z)

v1 = Vec3.new_copy({ 10.0, 11.0, 12.0 })
assert(10.0 == v1.x)
assert(11.0 == v1.y)
assert(12.0 == v1.z)

v2 = Vec3.new_copy(v1)
assert(10.0 == v2.x)
assert(11.0 == v2.y)
assert(12.0 == v2.z)
assert(not rawequal(v1, v2))

v2 = v1:new_copy()
assert(10.0 == v2.x)
assert(11.0 == v2.y)
assert(12.0 == v2.z)
assert(not rawequal(v1, v2))

v2 = Vec3(v1)
assert(10.0 == v2.x)
assert(11.0 == v2.y)
assert(12.0 == v2.z)
assert(not rawequal(v1, v2))

v1 = Vec3({ x = 13.0, y = 14.0, z = 15.0 })
assert(13.0 == v1.x)
assert(14.0 == v1.y)
assert(15.0 == v1.z)

v1 = Vec3({ 16.0, 17.0, 18.0 })
assert(16.0 == v1.x)
assert(17.0 == v1.y)
assert(18.0 == v1.z)

-- Length

v1 = Vec3(0.0, 0.0, 0.0)
assert(v1:len_sq() == 0.0)
assert(v1:len() == 0.0)

v1 = Vec3(1.0, 0.0, 0.0)
assert(v1:len_sq() == 1.0)
assert(v1:len() == 1.0)

v1 = Vec3(1.0, 1.0, 1.0)
assert(v1:len_sq() == 3.0)
assert(math.abs(v1:len() - math.sqrt(3.0)) < 0.001)

-- Unit Vectors

v1 = Vec3(7.0, 0.0, 0.0)
v2 = v1:unit()
assert(math.abs(v2.x - 1.0) < 0.001)
assert(math.abs(v2.y - 0.0) < 0.001)
assert(math.abs(v2.z - 0.0) < 0.001)
assert(math.abs(v2:len_sq() - 1.0) < 0.001)
assert(math.abs(v2:len() - 1.0) < 0.001)

v1 = Vec3(1.0, 1.0, 1.0)
v2 = v1:unit()
assert(math.abs(math.sqrt(3.0)*v2.x - 1.0) < 0.001)
assert(math.abs(math.sqrt(3.0)*v2.y - 1.0) < 0.001)
assert(math.abs(math.sqrt(3.0)*v2.z - 1.0) < 0.001)
assert(math.abs(v2:len_sq() - 1.0) < 0.001)
assert(math.abs(v2:len() - 1.0) < 0.001)

-- Multiplication

v1 = Vec3(1.0, 2.0, 3.0)
v2 = v1:mul(5.0)
assert(5.0 == v2.x)
assert(10.0 == v2.y)
assert(15.0 == v2.z)
assert(math.sqrt(25.0*v1:len_sq() - v2:len_sq()) < 0.001)
assert(math.sqrt(5.0*v1:len() - v2:len()) < 0.001)

-- Division

v1 = Vec3(1.0, 2.0, 3.0)
v2 = v1:div(2.0)
assert(0.5 == v2.x)
assert(1.0 == v2.y)
assert(1.5 == v2.z)
assert(math.sqrt(v1:len_sq() - 4.0*v2:len_sq()) < 0.001)
assert(math.sqrt(v1:len() - 2.0*v2:len()) < 0.001)

-- Negation

v1 = Vec3(5.0, 4.0, 3.0)
v2 = v1:unm()
assert(-5.0 == v2.x)
assert(-4.0 == v2.y)
assert(-3.0 == v2.z)

v2 = -v1
assert(-5.0 == v2.x)
assert(-4.0 == v2.y)
assert(-3.0 == v2.z)

-- Addition

v1 = Vec3(10.0, 20.0, 30.0)
v2 = Vec3(1.0, 2.0, 3.0)
v3 = v1:add(v2)
assert(11.0 == v3.x)
assert(22.0 == v3.y)
assert(33.0 == v3.z)

v3 = v1:add(5.0, 6.0, 7.0)
assert(15.0 == v3.x)
assert(26.0 == v3.y)
assert(37.0 == v3.z)

v2 = Vec3(-1.0, -2.0, -3.0)
v3 = v1 + v2
assert(9.0 == v3.x)
assert(18.0 == v3.y)
assert(27.0 == v3.z)


-- Subtraction

v1 = Vec3(10.0, 20.0, 30.0)
v2 = Vec3(1.0, 2.0, 3.0)
v3 = v1:sub(v2)
assert(9.0 == v3.x)
assert(18.0 == v3.y)
assert(27.0 == v3.z)

v3 = v1:sub(5.0, 6.0, 7.0)
assert(5.0 == v3.x)
assert(14.0 == v3.y)
assert(23.0 == v3.z)

v2 = Vec3(-1.0, -2.0, -3.0)
v3 = v1 - v2
assert(11.0 == v3.x)
assert(22.0 == v3.y)
assert(33.0 == v3.z)

-- Equality

v1 = Vec3(-3.0, -4.0, -5.0)
v2 = Vec3(-3.0, -4.0, -5.0)
v3 = v1:new_copy()
assert(v1:eq(v1))
assert(v1:eq(v2))
assert(v2:eq(v1))
assert(v1:eq(v3))
assert(v3:eq(v1))
assert(v1:eq(-3.0, -4.0, -5.0))
assert(v1:eq({ x = -3.0, y = -4.0, z = -5.0 }))
assert(v1:eq({ -3.0, -4.0, -5.0 }))

v1 = Vec3(6.0, 17.0, 83.0)
v2 = Vec3(6.0, 17.0, 83.0)
v3 = Vec3(v1)
assert(v1 == v1)
assert(v1 == v2)
assert(v2 == v1)
assert(v1 == v3)
assert(v3 == v1)
assert(v1:eq({ x = 6.0, y = 17.0, z = 83.0 }))
assert(not (v1 ~= v1))
assert(not (v1 ~= v2))
assert(not (v2 ~= v1))
assert(not (v1 ~= v3))
assert(not (v3 ~= v1))

-- Dot Product

v1 = Vec3(2.0, 3.0, 5.0)
v2 = Vec3(7.0, 11.0, 13.0)
assert(v1:dot(v2) == 112.0)
assert(v1:dotvec(v2) == 112.0)
assert(v1:dot(v1) == v1:len_sq())
assert(v1:dot(4.0, 3.0, 2.0) == 27.0)

v1 = Vec3(1.0, 0.0, 0.0)
assert(v1:dot(0.0, 1.0, 0.0) == 0.0)
assert(v1:dot(0.0, 0.0, 1.0) == 0.0)
assert(v1:dot(0.0, 1.0, 1.0) == 0.0)

-- Cross Product

v1 = Vec3(1.0, 0.0, 0.0)
v2 = Vec3(0.0, 1.0, 0.0)
assert(v1:cross(v1):eq(Vec3()))
assert(v2:cross(v2):eq(Vec3()))
assert(v1:cross(v2):eq({ 0.0, 0.0, 1.0 }))
assert(v2:cross(v1):eq({ 0.0, 0.0, -1.0 }))
assert(v1:cross(0.0, 0.0, 1.0):eq({ 0.0, -1.0, 0.0 }))
assert(Vec3.cross(Vec3(0.0, 1.0, 0.0), { 0.0, 0.0, 1.0 }):eq({ 1.0, 0.0, 0.0 }))

v1 = Vec3(3.0, 7.0, 17.0)
v2 = Vec3(2.0, 11.0, 19.0)
assert(v1:cross(v1):eq(Vec3()))
assert(v2:cross(v2):eq(Vec3()))
assert(v1:cross(v2):eq({ -54.0, -23.0, 19.0 }))
assert(v1:crossvec(v2):eq({ -54.0, -23.0, 19.0 }))
assert(v2:cross(v1):eq({ 54.0, 23.0, -19.0 }))
assert(v2:crossvec(v1):eq({ 54.0, 23.0, -19.0 }))

print("Vec3 unit test PASSED")
