A = [1 2 -1 0 0; 2 -3 0 -1 0; 1 0 0 0 1];
c = [2 3 0 0 0];
b = [4; -6; 5];

ib = [1 3 4];
in = [2 5];

[r,k,e] = from_basis_compute_all(A, b, c, ib, in, true);

%x = [5 0 1 16 0];
%y = [1 -1 -1 5 -1];

%x - 16/5*y
%rr= find([-1,-1]>0)
%isempty(rr)

total =0 
for i = 1:5 
    total = total + (i/5)^-1;
end
total