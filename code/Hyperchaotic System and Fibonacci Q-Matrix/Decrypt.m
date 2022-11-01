function I_dec=Decrypt(I_enc,SS)
if nargin<2
    error(' : Encrypted  Image and Key')
end
if isa(SS,'cell')~=1
    error('The Key suuld be Cell')
end
[M,N,nc]=size(I_enc);
C=double(I_enc);
A_=[34 -55;-55 89];
nrounds=length(SS);
for nround_iter=nrounds:-1:1
    for i=1:2:M
        for j=1:2:N
            Cx=[C(i,j) C(i,j+1)
                C(i+1,j) C(i+1,j+1)];
            fz=Cx*A_;
            D(i,j)=fz(1,1);
            D(i,j+1)=fz(1,2);
            D(i+1,j)=fz(2,1);
            D(i+1,j+1)=fz(2,2);
        end
    end
    S=SS{nround_iter};
    [~,S2]=sort(S);
    W=D(:);
    ER=W(S2);
    C=reshape(ER,[M N]);
    C=mod(C,256);
end
I_dec=uint8(C);