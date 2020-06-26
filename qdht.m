
function [r kr Hank iHank] = qdht(rmax,p,N);

%% Quasi-discrete Hankel transform (QDHT) of integer order p
%
%% Inputs:
% rmax is the approximate max(r)
% p is the order of the Bessel function (p = 0 works well)
% N is the number of points
%
%% Outputs:
% r returns the radial vector (uniformly distributed)
% kr returns the radial k vector
% Hank is the QDHT matrix
% iHank is the inverse QDHT matrix
%
% Adapted from the Matlab repository code, which is based on the paper
%
%     M. Guizar-Sicairos, J.C. Gutierrez-Vega, Computation of
%     quasi-discrete Hankel transforms of integer order for
%     propagating optical wave fields, J. Opt. Soc. Am. A 21,
%     53-58 (2004).
 

%% load bessel_roots, which is the 5 x 4097 matrix of roots of Jp

load('bessel_roots.mat');    

c        = bessel_roots( p + 1, 1:N );   % c is a vector of roots
RootMax  = bessel_roots( p + 1, N + 1 ); % RootMax is a scalar

% define the radial coordinate
r        = rmax/RootMax * c';

% define kr, the radial k vector
kr       = c'/rmax; 

B        = 2*sqrt(pi)*rmax/RootMax ./ besselj( p + 1, c );
A_inv    = repmat( B.^2, [N 1] );
Hank     = A_inv .* besselj( p, c'*c/RootMax );
iHank    = inv( Hank );
