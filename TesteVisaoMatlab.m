% Programa exemplo para formação de visão em Matlab / python set 2019
% Miguel Oliveira
clear all % limpar memoria toda
close all % fechar todas as janelas
clc % limpar o ecra do command window

% para ler a imagem do disco
A = imread('images/imagem_teste.jpeg');

% para mostrar a imagem numa janela
%imshow(A);

% converter a imagem para grayscale
B = rgb2gray(A);

% figure % criar nova figura
% imshow(B) % mostar imagem B
% title('Imagem B')
% pause(0.1)

C = B > 200;
M = logical(C);

% figure
% imshow(M)
% title('Imagem M ')
% pause(0.1)

% Proposta do Alex
linha_corte = size(B,1)/2;

% pintar de preto os pixeis de cima da imagem
M2 = M; % copiar M para M2
M2(1:linha_corte, :) = 0; % Pintar parte de cima de M2 a preto

%
% figure
% imshow(M2)
% title('Imagem M2 -> apagar parte cima')
% pause(0.1)


% solução João (ficar apenas com a parte de baixo da imagem)
M3 = M(linha_corte:end, :); % copiar parte de baixo de M para M3


% figure
% imshow(M4)
% title('Imagem M3 -> selecionar parte baixo')
% pause(0.1)

%% Luís
% percorrer cada linha da imagem e se encontrar mais do que T
% pixeis brancos seguidos apagá-los


T = 10;
D = uint8(M3)*255;
figure
imshow(D)
title('Imagem M3 -> selecionar parte baixo')
pause(0.1)


for linha = 1:size(M3,1)
    % linha = 60;
    
    brancos_seguidos = 0;
    cols_brancos = [];
    nos_brancos = 0; % sinaliza se estou a percorrer uma mancha brancos
    for col = 1:size(M3,2)
        
        if M3(linha, col) == 1 % se o pixel é branco
            if nos_brancos == 1
                brancos_seguidos = brancos_seguidos + 1;
                cols_brancos = [cols_brancos col];
            else % encontro branco mas não estava nos _brancos
                nos_brancos = 1;
                brancos_seguidos = brancos_seguidos + 1;
                cols_brancos = [cols_brancos col];
            end
%             D(linha,col) = 230;
%             imshow(D)
%             pause(0.01)
        else % encontra pixel preto
            if nos_brancos == 1
                % teste do Luis
                if brancos_seguidos > T % mancha branca muito grande apagar
                    D(linha, cols_brancos) = 0;
                end
                brancos_seguidos = 0;
                cols_brancos = [];
                
                
            else % encontro preto mas não estava nos_brancos
                % nothing to do for now ...
            end
        end
        
        
    end
    
end

imshow(D)