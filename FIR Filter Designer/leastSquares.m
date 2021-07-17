function [H_optimal,H_full] = leastSquares(N, k , w_cutoff)
    %N :The length of the filter
    %L :The number of taps in time domain(half the length of the filter -1)
    %k :The number of points in the desired frequency response
    %w_cutoff  : The cutoff frequency in rad/sec 
     
%      1  2cos(w1)    2cos(2w1)   2cos(3w1) .... 2cos(Lw1)     h(0)        H(w1)    
%      1  2cos(w2)    2cos(2w2)   2cos(3w2) .... 2cos(Lw2)     h(1)        H(w2) 
%      .                                                        .            .  
%      .                                                    *   .      =     .
%      .                                                        .            . 
%      1  2cos(wk)    2cos(2wk)   2cos(3wk) .... 2cos(Lwk)     h(L)        H(wk)
     
    
    L = (N-1)/2;
    
    w_k = pi * linspace(0,1,k);  %the frequencies vector
    H_d = zeros (1,k); % a vector that resembles the amplitude of the frequencies
    H_d( w_k <= w_cutoff ) = 1;  %Making the amplitude of frequencies less than the cutoff frequency equals 1
   
    %Constructing the F matrix 
    L_vector= 0:1:L;
    Lw_matrix = w_k' * L_vector; %Constructing the Lw_k part which is inside the cosine
    F = 2 * cos(Lw_matrix);
    F(:,1)= F(:,1)/2; % To make the first column = 1. Or i can simply say -->  F(:,1) = 1
    
    H_optimal = (F\ H_d')'; %The filter coefficients in the time domain
    
    %constructing the full filter coefficients where 
    H_full = zeros(1,N); 
    H_full = (fliplr(H_optimal(2:end)));
    H_full(L+1 : N) =  H_optimal;
    
    fvtool(H_full);
    
end