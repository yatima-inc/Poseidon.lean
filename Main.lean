import Poseidon.FFI

def main : IO Unit := do
  let a : ByteVector 32 := default
  let x := poseidonHash4 a a a a
  IO.println x.data
