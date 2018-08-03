clc;
format compact;
workspace;
fontSize = 20;
%% Read the image
Image = imread('lena_noisy.png');
%% Set the decrement value
prompt = 'Enter the decrement value: ';
dec = input(prompt);
prompt = 'Enter the threshold value: ';
thres = input(prompt);
%% Divide the image into 4x4 cells
cell = mat2cell(Image,4*ones(1,size(Image,1)/4),4*ones(1,size(Image,2)/4));
for c = 1 : size(cell, 2)
	for r = 1 : size(cell, 1)
		fprintf('c=%d, r=%d\n', c, r);
        %Apply 2D DCT to the active cell
        d{r,c} = dct2(cell{r,c});
        %Decrease low frequency elements of DCT cell
        d{r,c}(1,1) = d{r,c}(1,1) - dec;
        d{r,c}(2,1) = d{r,c}(2,1) - dec;
        d{r,c}(1,2) = d{r,c}(1,2) - dec;
        d{r,c}(2,2) = d{r,c}(2,2) - dec;
        %Decrease high frequency elements of DCT cell
        d{r,c}(3,3) = d{r,c}(3,3) - dec;
        d{r,c}(3,4) = d{r,c}(3,4) - dec;
        d{r,c}(4,3) = d{r,c}(4,3) - dec;
        d{r,c}(4,4) = d{r,c}(4,4) - dec;
        %Apply threshold
        d{r,c}(abs(d{r,c}) < thres) = 0;
        %Apple inverse DCT to the edited cell
        n{r,c} = idct2(d{r,c});
    end
end
%Reassemble 4x4 cells back into the image form
ImageX = cell2mat(n);
%% Final image
imshowpair(Image,ImageX,'montage')
title('Original Noisy Image (Left) and Processed Image (Right)');