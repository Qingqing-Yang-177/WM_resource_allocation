function [pHit] = calc_pHit(r,sigma)
% calculates the probability that the saccade target lands within the disk
% 
% R: radius of disk
% SIGMA: memory noise

% check to make sure r is a orizontal hvector
r = r(:)'; 

edgee = 2;
nsamps = 100;
rangee = linspace(-edgee,edgee,nsamps);

[xx,yy] = meshgrid(rangee,rangee);
xx = xx(:); yy = yy(:);

% tic;
pXgivenS = mvnpdf([xx yy],0,[sigma 0; 0 sigma]);
pXgivenS = exp(log(pXgivenS)- log(sum(pXgivenS))); % normalize

idxs = bsxfun(@(x,y) x <= y, xx.^2+yy.^2, r.^2); 
idxs = find(idxs);
idxs = mod(idxs,nsamps^2);
idxs(idxs==0) = nsamps^2; 
pHit = sum(pXgivenS(idxs));
% toc

% tic;
% rVec = r;
% nR = length(rVec);
% for iR = 1:nR
%     r = rVec(iR);
%     
%     pXgivenS = mvnpdf([xx yy],0,[sigma 0; 0 sigma]);
%     pXgivenS = exp(log(pXgivenS)- log(sum(pXgivenS))); % normalize
%     
%     idxs = xx.^2+yy.^2 <= r.^2;
%     pHit = sum(pXgivenS(idxs));
% end
% toc