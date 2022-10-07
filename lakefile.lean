import Lake
open Lake DSL

package Poseidon 

@[defaultTarget]
lean_lib Poseidon

require YatimaStdLib from git
  "https://github.com/yatima-inc/YatimaStdLib.lean" @ "868abcb58c5d96927c65ac304ee1e99a21d57457"

require LSpec from git
   "https://github.com/yatima-inc/LSpec" @ "a8dc2f38fc38f16efcc877ca8a4c7b37d3965db0"

require mathlib from git
   "https://github.com/leanprover-community/mathlib4" @ "dd1ecc5d3aefab6a83767079c7d020f4aa254a24"
