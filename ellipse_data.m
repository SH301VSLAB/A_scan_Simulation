function [theta, phi, dt]=ellipse_data( )
% [theta, phi, dt] = ellipse_data( ) returns experimental sizing data 
% for a 2.5 x 0.6 mm elliptical crack in titanium(c = 6100 m/sec) as
% measured with a phased array where (theta, phi) are spherical angles (in
% degrees) and dt is the measured time between flash points (in
% microseconds). The data has been corrected for finite bandwidth errors.

% look angles (in degrees)        
theta(1) = 55; phi(1) =90;
theta(2) = 50; phi(2) = 90;
theta(3) = 45; phi(3) = 90;
theta(4) = 40; phi(4) = 90;
theta(5) = 55 ;phi(5) = 60;
theta(6) =50  ;phi(6) = 60;
theta(7) =45  ;phi(7) = 60;
theta(8) = 40 ;phi(8) = 60;
theta(9) = 40 ;phi(9) = 45;
theta(10) = 45 ;phi(10) = 45;
theta(11) = 50 ;phi(11) = 45 ;
theta(12) = 55 ;phi(12) = 45 ;


% times of separation between flashpoints (in microseconds)as corrected for
% bandwidth errors

dt(1) =0.362;
dt(2) = 0.332 ;
dt(3) = 0.282 ;
dt(4) =  0.252;
dt(5) =0.714 ;
dt(6) = 0.652 ;
dt(7) =0.602 ;
dt(8) =0.532 ;
dt(9) =0.684 ;
dt(10)=0.782 ;
dt(11) = 0.852;
dt(12) = 0.954;