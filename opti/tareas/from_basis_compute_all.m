function [] = from_basis_compute_all(basis, b, c, Ib, In)

    B = basis(:, Ib);
    N = basis(:, In);
    B_ = inv(B);
    
    xb = B_ * b
    Cj = c(:,In) - c(:,Ib)*B_*N 
    N;
end