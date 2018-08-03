clc;
format compact;
workspace;
fontSize = 20;
%% Read the image
Image = imread('cat.jpg');
%% Add noise
Noise_level = 0.1;
Noisy = imnoise(Image,'salt & pepper',Noise_level);
%% Set the decrement value
prompt = 'Enter the decrement value: ';
dec = input(prompt);
prompt = 'Enter the threshold value: ';
thres = input(prompt);
%% Divide the image into 8x8 cells
cell = mat2cell(Noisy,8*ones(1,size(Noisy,1)/8),8*ones(1,size(Noisy,2)/8));
for c = 1 : size(cell, 2)
	for r = 1 : size(cell, 1)
		fprintf('c=%d, r=%d\n', c, r);
        %Apply 2D DCT to the active cell
        d{r,c} = dct2(cell{r,c});
        %Decrease low frequency elements of DCT cell
        d{r,c}(1,1) = d{r,c}(1,1) - dec;
        d{r,c}(2,1) = d{r,c}(2,1) - dec;
        d{r,c}(1,2) = d{r,c}(1,2) - dec;
        d{r,c}(3,1) = d{r,c}(3,1) - dec;
        d{r,c}(4,1) = d{r,c}(4,1) - dec;
        d{r,c}(2,2) = d{r,c}(2,2) - dec;
        d{r,c}(3,2) = d{r,c}(3,2) - dec;
        d{r,c}(1,3) = d{r,c}(1,3) - dec;
        d{r,c}(2,3) = d{r,c}(2,3) - dec;
        d{r,c}(1,4) = d{r,c}(1,4) - dec;

        %Apply threshold
        d{r,c}(abs(d{r,c}) < thres) = 0;
        %Apply inverse DCT to the edited cell
        n{r,c} = idct2(d{r,c});
    end
end
%Reassemble 8x8 cells back into the image form
ImageX = cell2mat(n);
%% Final image
imshowpair(Noisy,ImageX,'montage')
title('Original Noisy Image (Left) and Processed Image (Right)');