function [] = from_basis_compute_all(basis, b, c, Ib, In)

    %matriz basica
    B = basis(:, Ib);
    %matriz no basica
    N = basis(:, In);
    %matriz inversa de la base
    B_ = inv(B);
    
    %soluciones basicas
    xb = B_ * b;
    
    %vector de la solución
    x(Ib) = xb;
    x(In) = zeros(size(In));
    
    %costos reducidos
    Cj = c(:,In) - c(:,Ib)*B_*N;
    
    %función objetivo
    fo = c.*x
end