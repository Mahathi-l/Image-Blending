A = imread('lena.png');
imshow(A)

%%
% First, we need to compute the multiresolution pyramid using the
% function I presented previously.

mrp = multiresolutionPyramid(im2double(A));

%%
% Now we follow the computational recipe that I described in words
% above.

lapp = cell(size(mrp));
num_levels = numel(mrp);
lapp{num_levels} = mrp{num_levels};
for k = 1:(num_levels - 1)
   A = mrp{k};
   B = imresize(mrp{k+1},2,'lanczos3');
   [M,N,~] = size(A);
   lapp{k} = A - B(1:M,1:N,:);
end
lapp{end} = mrp{end};

%%
% Another function, |showLaplacianPyramid| (also at the end of this
% script), visualizes the pyramid.

showLaplacianPyramid(lapp)

%%
% Given a Laplacian pyramid, we can reconstruct the original image by
% reversing the recipe above. 

num_levels = numel(lapp);
B = lapp{end};
for k = (num_levels - 1) : -1 : 1
   B = imresize(B,2,'lanczos3');
   Lk = lapp{k};
   [M,N,~] = size(Lk);
   B = B(1:M,1:N,:) + Lk;
end
imshow(B)