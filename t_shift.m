function  y = t_shift(x, n)
% >> y = t_shift(x, n). A function which is used in conjunction with the 
% c_shift function to change the time axis values appropriately so that the
% time axis is shifted along with the function. 
% Example use:  plot(t_shift(t, 100), c_shift(fun, 100))

[nr,nc]= size(x);
dx = x(2) -x(1);
if nr == 1
    len = nc;
    y = [x(len-n+1 : end)-x(end)-dx+x(1), x(1:len -n)];
elseif nc == 1
    len = nr;
    y = [x(len-n+1 : end)-x(end)-dx+x(1); x(1:len -n)];
else
    error(' t_shift only works with vectors')
end