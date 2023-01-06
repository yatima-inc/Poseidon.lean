use neptune::poseidon::{Poseidon, PoseidonConstants};
use blstrs::Scalar as Fr;
use ff::PrimeField;
use generic_array::typenum;

fn scalar_from_u8s(bytes: &[u8; 32]) -> Fr {
    Fr::from_repr_vartime(*bytes).expect("u8s exceed BLS12-381 scalar field modulus")
}

#[no_mangle]
extern "C" fn hash_4(mem: &mut [u8; 32],
        a: &[u8; 32], b: &[u8; 32], c: &[u8; 32], d: &[u8; 32]) {
    let preimage = [
        scalar_from_u8s(a),
        scalar_from_u8s(b),
        scalar_from_u8s(c),
        scalar_from_u8s(d)
    ];
    let constants = PoseidonConstants::new();

    let mut h =
        Poseidon::<Fr, typenum::U4>::new_with_preimage(&preimage, &constants);

    *mem = h.hash().to_bytes_le();
}
