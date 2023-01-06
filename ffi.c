#include <lean/lean.h>

#define intern inline static
#define l_arg b_lean_obj_arg
#define l_res lean_obj_res 

intern lean_sarray_object* mk_byte_array_from(size_t len) {
    lean_sarray_object* o = (lean_sarray_object*)lean_alloc_object(
        sizeof(lean_sarray_object) + len
    );
    lean_set_st_header((lean_object*)o, LeanScalarArray, 1);
    o->m_size = len;
    o->m_capacity = len;
    return o;
}

extern l_res lean_poseidon_hash_4 (l_arg a, l_arg b, l_arg c, l_arg d) {
    lean_sarray_object* answer = mk_byte_array_from(32); 

    hash_4(
        answer->m_data,
        lean_to_sarray(a)->m_data,
        lean_to_sarray(b)->m_data,
        lean_to_sarray(c)->m_data,
        lean_to_sarray(d)->m_data
    );

    return (lean_object*)answer;
}
