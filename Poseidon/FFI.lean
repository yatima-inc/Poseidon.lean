import YatimaStdLib.ByteVector

@[extern "lean_poseidon_hash_4"]
opaque poseidonHash4 : (a b c d : ByteVector 32) → ByteVector 32
