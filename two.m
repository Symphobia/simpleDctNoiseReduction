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
%% Divide the image into 2x2 cells
cell = mat2cell(Image,2*ones(1,size(Image,1)/2),2*ones(1,size(Image,2)/2));
for c = 1 : size(cell, 2)
	for r = 1 : size(cell, 1)
		fprintf('c=%d, r=%d\n', c, r);
        %Apply 2D DCT to the active cell
        d{r,c} = dct2(cell{r,c});
        %Decrease low frequency element of DCT cell
        d{r,c}(1,1) = d{r,c}(1,1) - dec;
        %Decrease high frequency element of DCT cell
        d{r,c}(2,2) = d{r,c}(2,2) - dec;
        %Apply threshold
        d{r,c}(abs(d{r,c}) < thres) = 0;
        %Appy inverse DCT to the edited cell
        n{r,c} = idct2(d{r,c});
    end
end
%Reassemble 2x2 cells back into the image form
ImageX = cell2mat(n);
%% Final image
imshowpair(Image,ImageX,'montage')
title('Original Noisy Image (Left) and Processed Image (Right)');