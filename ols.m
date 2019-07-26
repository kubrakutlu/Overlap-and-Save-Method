%% Overlap and Save Method
% Kübra Kutlu
% Cansu Demirkiran
% -------------------------------------------------------------------------
clear all
% Parameters
P = 1024; % signal x length
M = 16; % filter length
L = 128; % block size

% Signals
X = ones (1,P);
h = ones (1,M);

% Theoritical Result of Circular Convolution
n = P+M-1;
xpad = [X zeros(1,n-P)];
hpad = [h zeros(1,n-M)];
ccirc = ifft(fft(xpad).*fft(hpad));
ccirc = ccirc(1:n);
convv = conv(X,h);

% Overlap-and-Save Method
h = [h zeros(1,L-1)]; % pad with zeros for multiplication
h_dft=fft(h);
N = L+M-1; % length of y, also length of input blocks
a = P/L; % number of input blocks
C = zeros(a,N); % matrix containing input blocks
C(1,:)=[zeros(1,M-1) X(1:L)]; % add #M-1 zeros to first block

% Obtain input blocks starting from second block
for i=2:a
   C(i,:)= X((i-1)*L-(M-1):(i)*L-1);
end    

for m=1:a
    C_dft = fft(C(m,:));
    Y(m,:)=C_dft.*h_dft;
    y_temp(m,:)=ifft(Y(m,:));
    y(m,:)=y_temp(m,M:end);
end

%h_mtc = toeplitz(h);

%Y=zeros(a,L);
%for i=1:a
 %   V=h_mtc*C(i,:)';
  %  Y(i,:)=V(M:end);
%end    
y = y';

result = y(:);

