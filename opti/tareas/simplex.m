function simplex(basis, b, c, Ib, In)

    [in_indx, out_indx, ext_code] = from_basis_compute_all(basis, b, c, Ib, In)
    
    disp(in_indx, out_indx, ext_code)
end