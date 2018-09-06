function v =init_z(setup)
% get parameters that may not be scalars
f =setup.f;
z1 = setup.geom.z1;
z2=setup.geom.z2;
x2 =setup.geom.x2;
y2 = setup.geom.y2;
%get dimensions, put in rows
A = [size(f); size(z1);size(z2);size(x2); size(y2)];
%get product of dimensions for each varaible
prod =A(:,1).*A(:,2); % this is a column vector
%find which row (or rows) have largest dimension
ind = find( prod == max(prod));
%pick first row with largest dimension
val = ind(1);
% initialize v with zeros of same size
% as the parameter(s) with largest dimensions
v = zeros(A(val,:));
