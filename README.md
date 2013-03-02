minetest-lib-Vec3
=================

Provides a Vec3 "class" full of useful operations and 100% compatible with
Minetest table-based vectors.

General
=======

This is NOT a "mod"; it is a LIBRARY for use by mods and other libraries.  That
means it does not modify how Minetest works in any way, but provides a useful
API to help mods do so.  This library is for 3D vector-based math operations.

Author: prestidigitator (as registered at forum.minetest.net)
Copyright: 2013, licensed under WTFPL

Installation
============

The file "lib/Vec3_1-0.lua" should be placed in a "lib" subdirectory of your
main mode folder.  For example, if your mod is installed in:

   .../mods/minetest/my_mod

Then the file should have the path:

   .../mods/minetest/my_mod/lib/Vec3_1-0.lua

The library may then be loaded from your mod code directly:

   local MOD_NAME = minetest.get_current_modname()
   local MOD_PATH = minetest.get_modpath(MOD_NAME)
   local Vec3 = dofile(MOD_PATH.."/lib/Vec3_1-0.lua")

...or using the ModLib library's automatic version-managed loading to load any
version from 1.0 up that is available through any mod including this one:

   local MOD_NAME = minetest.get_current_modname()
   local MOD_PATH = minetest.get_modpath(MOD_NAME)

   local ModLib = dofile(MOD_PATH.."/lib/ModLib.lua")
   ModLib.addDir(MOD_PATH.."/lib")

   local Vec3 = ModLib.load("Vec3", "1.0")

Examples of Use
===============

This uses concise overloaded vector operators to find a point 10m from the
camera in the direction the player's viewer is looking and return the type of
node at that position:

   local EYE_OFFSET = Vec3(0.0, 1.5, 0.0)

   local function find_look_at_10m(player)
      local eyePos = Vec3(player:getpos()) + EYE_OFFSET
      local eyeDir = Vec3(player:get_look_dir())
      local pos = eyePos + 10.0 * eyeDir
      return minetest.env:get_node(pos).name
   end

This uses more functional syntax to test whether a player is within 30m of a
given position:

   local function closer_than_30m(player, pos)
      return Vec3.sub(player:getpos(), pos).len_sq() < 30.0^2
   end

This "pushes" a physical entity away from a player at a speed of 10m/s:

   local function push_away(player, entity)
      local offset = Vec3.sub(entity:getpos(), player:getpos())
      local dir = offset:unit()
      entity.setvelocity(10.0 * dir)
   end

API Docs
========

Vec3
----
3D vector class/operations.

Note that methods can be called in either an object-oriented way:

   v1 = Vec3(1, 2, 3)
   v2 = v1:add({ x = 2, y = 2, z = 0 })

or as simple functions:

   Vec3.add({ x = 1, y = 2, z = 3 }, { x = 2, y = 2, z = 0 })

All methods that can be called on a Vec3 using ":" may be called on a table
using the second functional syntax, but the first parameter MUST have the
expected components "x", "y", and "z".  If a vector is used as the second
paramter, it may instead be a list/array with numeric indices, like
{ 1.0, 2.0, 3.0 } in place of { x = 1.0, y = 2.0, z = 3.0 }.

Vec3.new
--------
Constructs a Vec3 from three numbers.

Call with one of:

   Vec3.new(x, y, z)
   Vec3(x, y, z)

Returns a new Vec3 object

Vec3.new_copy
-------------
Constructs a new copy of a Vec3.

Call with one of:

   vec:new_copy()
   Vec3.new_copy(vec)
   Vec3(vec)

Returns a new Vec3 object that is a copy of the parameter

Vec3.len_sq
-----------
Computes the square of the length of a Vec3.

Call with one of:

   vec:len_sq()
   Vec3.len_sq(vec)

Returns a number

Vec3.len
--------
Computes the length of a Vec3.

Call with one of:

   vec:len()
   Vec3.len(vec)

Returns a number

Vec3.unit
---------
Computes a unit vector pointing in the same direction as a Vec3.
Undefined for a zero-vector and may throw an error.

Call with one of:

   vec:unit()
   Vec3.unit(vec)

Returns a new Vec3 with length 1.0

Vec3.mul
--------
Multiplies a Vec3 by a number.

Call with one of:

   vec:mul(m)
   Vec3.mul(vec, m)
   vec*m
   m*vec

Returns a new Vec3 object with the result of the operation

Vec3.div
--------
Divides a Vec3 by a number.

Call with one of:

   vec:div(m)
   Vec3.div(vec, m)
   vec/m

Returns a new Vec3 object with the result of the operation

Vec3.unm
--------
Negates a Vec3 (signs of all components are inverted).

Call with one of:

   vec:unm()
   Vec3.unm(vec)
   -vec

Returns a new Vec3 object with the result of the operation

Vec3.add
--------
Adds two Vec3s or a Vec3 composed of three given components.

Call with one of:

   vec1:add(vec2)
   vec1:add(x, y, z)
   Vec3.add(vec1, vec2)
   Vec3.add(vec1, x, y, z)
   vec1 + vec2

Returns a new Vec3 object with the result of the operation

Vec3.sub
--------
Subtracts two Vec3s or a Vec3 composed of three given components.

Call with one of:

   vec1:sub(vec2)
   vec1:sub(x, y, z)
   Vec3.sub(vec1, vec2)
   Vec3.sub(vec1, x, y, z)
   vec1 - vec2

Returns a new Vec3 object with the result of the operation

Vec3.eq
-------
Tests two Vec3s or a Vec3 composed of three given components for
exact component-wise equality.

Call with one of:

   vec1:eq(vec2)
   vec1:eq(x, y, z)
   Vec3.eq(vec1, vec2)
   Vec3.eq(vec1, x, y, z)
   vec1 == vec2
   vec1 ~= vec2

Note that because of built-in Lua logic "==" and "~=" work ONLY if
vec1 and vec2 are actually Vec3s (not tables).

Returns a new Vec3 object with the result of the operation

Vec3.dot
--------
Takes the dot product of a Vec3 and a Vec3s or a Vec3 composed of
three given components.

Call with one of:

   vec1:dot(vec2)
   vec1:dot(x, y, z)
   Vec3.dot(vec1, vec2)
   Vec3.dot(vec1, x, y, z)

Returns a number

Vec3.cross
----------
Takes the cross product of a Vec3 and a Vec3s or a Vec3 composed of
three given components.

Call with one of:

   vec1:cross(vec2)
   vec1:cross(x, y, z)
   Vec3.cross(vec1, vec2)
   Vec3.cross(vec1, x, y, z)

Returns a new Vec3 with the result of the operation

Vec3.rot_around
---------------
Rotates this (the first) vector around the second vector by the
given angle.

Call with one of:

   vec:rot_around(axis, angle)
   Vec3.rot_around(vec, axis, angle)

Param axis - The axis about which to rotate.
Param angle - The angle by which to rotate this vector, in radians.
Returns a new Vec3 with the result of the operation.

Vec3.addvec
-----------
Adds two Vec3s. Optimized for pure Vec3/table operations by removing
type checking and conditionals.  If called with Vec3-likes table(s),
ensure all expected components "x", "y", and "z" exist.

Call with one of:

   vec1:addvec(vec2)
   Vec3.addvec(vec1, vec2)

Returns a new Vec3 object with the result of the operation

Vec.subvec
----------
Subtracts two Vec3s. Optimized for pure Vec3/table operations by
removing type checking and conditionals.  If called with Vec3-likes
table(s), ensure all expected components "x", "y", and "z" exist.

Call with one of:

   vec1:subvec(vec2)
   Vec3.subvec(vec1, vec2)

Returns a new Vec3 object with the result of the operation

Vec3.eqvec
----------
Tests two Vec3s for exact component-wise equality. Optimized for pure
Vec3/table operations by removing type checking and conditionals.
If called with Vec3-likes table(s), ensure all expected components
"x", "y", and "z" exist.

Call with one of:

   vec1:eqvec(vec2)
   Vec3.eqvec(vec1, vec2)

Returns a new Vec3 object with the result of the operation

Vec3.dotvec
-----------
Takes the dot product of two Vec3s. Optimized for pure Vec3/table
operations by removing type checking and conditionals.  If called
with Vec3-likes table(s), ensure all expected components "x", "y",
and "z" exist.

Call with one of:

   vec1:dotvec(vec2)
   Vec3.dotvec(vec1, vec2)

Returns a number

Vec3.crossvec
-------------
Takes the cross product of two Vec3s. Optimized for pure Vec3/table
operations by removing type checking and conditionals.  If called
with Vec3-likes table(s), ensure all expected components "x", "y",
and "z" exist.

Call with one of:

   vec1:crossvec(vec2)
   Vec3.crossvec(vec1, vec2)

Returns a new Vec3 with the result of the operation

Vec3.tostring
-------------
Converts Vec3 to a string with format "(x,y,z)".

Call with one of:

   vec:tostring()
   Vec3.tostring(vec)
   tostring(vec)

Returns a string

