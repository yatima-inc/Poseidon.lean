import Lake
open Lake DSL

package Poseidon where
  moreLinkArgs := #["-lrust_ffi", "-L", "./target/release"]

@[default_target]
lean_lib Poseidon

require YatimaStdLib from git
  "https://github.com/yatima-inc/YatimaStdLib.lean" @ "f452d52c281031a7c3cba5e465a8dc6241209ed3"

require LSpec from git
  "https://github.com/yatima-inc/LSpec.git" @ "129fd4ba76d5cb9abf271dc29208a28f45fd981e"

-- Tests
lean_exe Tests.RoundNumbers
lean_exe Tests.RoundConstants
lean_exe Tests.Hash

def ffiC := "ffi.c"
def ffiO := "ffi.o"

target importTarget (pkg : Package) : FilePath := do
  let oFile := pkg.oleanDir / ffiO
  let srcJob ← inputFile $ pkg.dir / ffiC
  buildFileAfterDep oFile srcJob fun srcFile => do
    let flags := #["-I", (← getLeanIncludeDir).toString]
    compileO ffiC oFile srcFile flags

extern_lib libffi (pkg : Package) := do
  proc { cmd := "cargo", args := #["build", "--release"] }
  let name := nameToStaticLib "ffi"
  let job ← fetch <| pkg.target ``importTarget
  buildStaticLib (pkg.libDir / name) #[job]

lean_exe test where
  root := `Main
