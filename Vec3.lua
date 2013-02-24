local Vec3_obj_meta = {}

--- 3D vector class/operations.
 --
 -- Note that methods can be called in either an object-oriented way:
 --    v1 = Vec3(1, 2, 3)
 --    v2 = v1:add({ x = 2, y = 2, z = 0 })
 -- or as simple functions:
 --    Vec3.add({ x = 1, y = 2, z = 3 }, { x = 2, y = 2, z = 0 })
 --
 -- All methods that can be called on a Vec3 using ":" may be called on a table
 -- using the second functional syntax, but the first parameter MUST have the
 -- expected components "x", "y", and "z".  If a vector is used as the second
 -- paramter, it may instead be a list/array with numeric indices, like
 -- { 1.0, 2.0, 3.0 } in place of { x = 1.0, y = 2.0, z = 3.0 }.
 --
 -- @author prestidigitator (as registered at forum.minetest.net)
 -- @copyright 2013, licensed under WTFPL
 --
Vec3 =
   {
      --- Constructs a Vec3 from three numbers.
       --
       -- Call with one of:
       --    Vec3.new(x, y, z)
       --    Vec3(x, y, z)
       --
       -- @return a new Vec3 object
      new = function(x, y, z)
         local obj = { x = x or 0.0, y = y or 0.0, z = z or 0.0 }
         setmetatable(obj, Vec3_obj_meta)
         return obj
      end,

      --- Constructs a new copy of a Vec3.
       --
       -- Call with one of:
       --    vec:new_copy()
       --    Vec3.new_copy(vec)
       --    Vec3(vec)
       --
       -- @return a new Vec3 object that is a copy of the parameter
      new_copy = function(v)
         local obj = { x = v.x or v[1] or 0.0,
                       y = v.y or v[2] or 0.0,
                       z = v.z or v[3] or 0.0 }
         setmetatable(obj, Vec3_obj_meta)
         return obj
      end,

      --- Computes the square of the length of a Vec3.
       --
       -- Call with one of:
       --    vec:len_sq()
       --    Vec3.len_sq(vec)
       --
       -- @return A number
      len_sq = function(v)
         return v.x^2 + v.y^2 + v.z^2
      end,

      --- Computes the length of a Vec3.
       --
       -- Call with one of:
       --    vec:len()
       --    Vec3.len(vec)
       --
       -- @return A number
      len = function(v)
         return math.sqrt(v.x^2 + v.y^2 + v.z^2)
      end,

      --- Computes a unit vector pointing in the same direction as a Vec3.
       -- Undefined for a zero-vector and may throw an error.
       --
       -- Call with one of:
       --    vec:unit()
       --    Vec3.unit(vec)
       --
       -- @return A new Vec3 with length 1.0
      unit = function(v)
         local len = math.sqrt(v.x^2 + v.y^2 + v.z^2)
         return Vec3.new(v.x/len, v.y/len, v.z/len)
      end,

      --- Multiplies a Vec3 by a number.
       --
       -- Call with one of:
       --    vec:mul(m)
       --    Vec3.mul(vec, m)
       --    vec*m
       --    m*vec
       --
       -- @return a new Vec3 object with the result of the operation
      mul = function(v, m)
         return Vec3.new(v.x*m, v.y*m, v.z*m)
      end,

      --- Divides a Vec3 by a number.
       --
       -- Call with one of:
       --    vec:div(m)
       --    Vec3.div(vec, m)
       --    vec/m
       --
       -- @return a new Vec3 object with the result of the operation
      div = function(v, m)
         return Vec3.new(v.x/m, v.y/m, v.z/m)
      end,

      --- Negates a Vec3 (signs of all components are inverted).
       --
       -- Call with one of:
       --    vec:unm()
       --    Vec3.unm(vec)
       --    -vec
       --
       -- @return a new Vec3 object with the result of the operation
      unm = function(v)
         return Vec3.new(-v.x, -v.y, -v.z)
      end,

      --- Adds two Vec3s or a Vec3 composed of three given components.
       --
       -- Call with one of:
       --    vec1:add(vec2)
       --    vec1:add(x, y, z)
       --    Vec3.add(vec1, vec2)
       --    Vec3.add(vec1, x, y, z)
       --    vec1 + vec2
       --
       -- @return a new Vec3 object with the result of the operation
      add = function(v, a, b, c)
         if type(a) == "table" then
            return Vec3.new(v.x + (a.x or a[1] or 0.0),
                            v.y + (a.y or a[2] or 0.0),
                            v.z + (a.z or a[3] or 0.0))
         else
            return Vec3.new(v.x + a, v.y + b, v.z + c)
         end
      end,

      --- Subtracts two Vec3s or a Vec3 composed of three given components.
       --
       -- Call with one of:
       --    vec1:sub(vec2)
       --    vec1:sub(x, y, z)
       --    Vec3.sub(vec1, vec2)
       --    Vec3.sub(vec1, x, y, z)
       --    vec1 - vec2
       --
       -- @return a new Vec3 object with the result of the operation
      sub = function(v, a, b, c)
         if type(a) == "table" then
            return Vec3.new(v.x - (a.x or a[1] or 0.0),
                            v.y - (a.y or a[2] or 0.0),
                            v.z - (a.z or a[3] or 0.0))
         else
            return Vec3.new(v.x - a, v.y - b, v.z - c)
         end
      end,

      --- Tests two Vec3s or a Vec3 composed of three given components for
       -- exact component-wise equality.
       --
       -- Call with one of:
       --    vec1:eq(vec2)
       --    vec1:eq(x, y, z)
       --    Vec3.eq(vec1, vec2)
       --    Vec3.eq(vec1, x, y, z)
       --    vec1 == vec2
       --    vec1 ~= vec2
       -- Note that because of built-in Lua logic "==" and "~=" work ONLY if
       -- vec1 and vec2 are actually Vec3s (not tables).
       --
       -- @return a new Vec3 object with the result of the operation
      eq = function(v, a, b, c)
         if type(a) == "table" then
            return v.x == (a.x or a[1] or 0.0) and
                   v.y == (a.y or a[2] or 0.0) and
                   v.z == (a.z or a[3] or 0.0)
         else
            return v.x == a and v.y == b and v.z == c
         end
      end,

      --- Takes the dot product of a Vec3 and a Vec3s or a Vec3 composed of
       -- three given components.
       --
       -- Call with one of:
       --    vec1:dot(vec2)
       --    vec1:dot(x, y, z)
       --    Vec3.dot(vec1, vec2)
       --    Vec3.dot(vec1, x, y, z)
       --
       -- @return a number
      dot = function(v, a, b, c)
         if type(a) == "table" then
            return v.x * (a.x or a[1] or 0.0) +
                   v.y * (a.y or a[2] or 0.0) +
                   v.z * (a.z or a[3] or 0.0)
         else
            return v.x * a + v.y * b + v.z * c
         end
      end,

      --- Takes the cross product of a Vec3 and a Vec3s or a Vec3 composed of
       -- three given components.
       --
       -- Call with one of:
       --    vec1:cross(vec2)
       --    vec1:cross(x, y, z)
       --    Vec3.cross(vec1, vec2)
       --    Vec3.cross(vec1, x, y, z)
       --
       -- @return a new Vec3 with the result of the operation
      cross = function(v, a, b, c)
         local ux, uy, uz
         if type(a) == "table" then
            ux = a.x or a[1] or 0.0
            uy = a.y or a[2] or 0.0
            uz = a.z or a[3] or 0.0
         else
            ux = a or 0.0
            uy = b or 0.0
            uz = c or 0.0
         end

         return Vec3.new(v.y*uz - v.z*uy, v.z*ux - v.x*uz, v.x*uy - v.y*ux)
      end,

      --- Rotates this (the first) vector around the second vector by the
       -- given angle.
       --
       -- Call with one of:
       --    vec:rot_around(axis, angle)
       --    Vec3.rot_around(vec, axis, angle)
       --
       -- @param axis
       --    The axis about which to rotate.
       -- @param angle
       --    The angle by which to rotate this vector, in radians.
       -- @return
       --    a new Vec3 with the result of the operation.
      rot_around = function(v, axis, angle)
         local uaxis = Vec3.new_copy(axis):unit()

         local alen = uaxis:dotvec(v)
         local avec = uaxis:mul(alen)

         local pvec = Vec3.subvec(v, avec)
         local rvec = uaxis:crossvec(v)

         local v1 = pvec:mul(math.cos(angle))
         local v2 = rvec:mul(math.sin(angle))

         return avec:addvec(v1):addvec(v2)
      end,

      --- Adds two Vec3s. Optimized for pure Vec3/table operations by removing
       -- type checking and conditionals.  If called with Vec3-likes table(s),
       -- ensure all expected components "x", "y", and "z" exist.
       --
       -- Call with one of:
       --    vec1:addvec(vec2)
       --    Vec3.addvec(vec1, vec2)
       --
       -- @return a new Vec3 object with the result of the operation
      addvec = function(v1, v2)
         return Vec3.new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
      end,

      --- Subtracts two Vec3s. Optimized for pure Vec3/table operations by
       -- removing type checking and conditionals.  If called with Vec3-likes
       -- table(s), ensure all expected components "x", "y", and "z" exist.
       --
       -- Call with one of:
       --    vec1:subvec(vec2)
       --    Vec3.subvec(vec1, vec2)
       --
       -- @return a new Vec3 object with the result of the operation
      subvec = function(v1, v2)
         return Vec3.new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
      end,

      --- Tests two Vec3s for exact component-wise equality. Optimized for pure
       -- Vec3/table operations by removing type checking and conditionals.
       -- If called with Vec3-likes table(s), ensure all expected components
       -- "x", "y", and "z" exist.
       --
       -- Call with one of:
       --    vec1:eqvec(vec2)
       --    Vec3.eqvec(vec1, vec2)
       --
       -- @return a new Vec3 object with the result of the operation
      eqvec = function(v1, v2)
         return v1.x == v2.x and v1.y == v2.y and v1.z == v2.z
      end,

      --- Takes the dot product of two Vec3s. Optimized for pure Vec3/table
       -- operations by removing type checking and conditionals.  If called
       -- with Vec3-likes table(s), ensure all expected components "x", "y",
       -- and "z" exist.
       --
       -- Call with one of:
       --    vec1:dotvec(vec2)
       --    Vec3.dotvec(vec1, vec2)
       --
       -- @return a number
      dotvec = function(v1, v2)
         return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
      end,

      --- Takes the cross product of two Vec3s. Optimized for pure Vec3/table
       -- operations by removing type checking and conditionals.  If called
       -- with Vec3-likes table(s), ensure all expected components "x", "y",
       -- and "z" exist.
       --
       -- Call with one of:
       --    vec1:crossvec(vec2)
       --    Vec3.crossvec(vec1, vec2)
       --
       -- @return a new Vec3 with the result of the operation
      crossvec = function(v1, v2)
         return Vec3.new(v1.y*v2.z - v1.z*v2.y,
                         v1.z*v2.x - v1.x*v2.z,
                         v1.x*v2.y - v1.y*v2.x)
      end,

      --- Converts Vec3 to a string with format "(x,y,z)".
       --
       -- @return a string
      tostring = function(v)
         return "("..
                (v.x or v[1] or "0")
                ..","..
                (v.y or v[2] or "0")
                ..","..
                (v.z or v[3] or "0")
                ..")"
      end
   }

Vec3_obj_meta.__index = Vec3
Vec3_obj_meta.__add = Vec3.addvec
Vec3_obj_meta.__sub = Vec3.subvec
Vec3_obj_meta.__div = Vec3.div
Vec3_obj_meta.__unm = Vec3.unm
Vec3_obj_meta.__eq = Vec3.eq
Vec3_obj_meta.__tostring = Vec3.tostring

Vec3_obj_meta.__mul = function(a, b)
   if type(a) == "table" then
      return Vec3.mul(a, b)
   else
      return Vec3.mul(b, a)
   end
end

setmetatable(
   Vec3,
   {
      __call = function(dummy, a, b, c)
         if type(a) == "table" then
            return Vec3.new_copy(a)
         else
            return Vec3.new(a, b, c)
         end
      end
   })

