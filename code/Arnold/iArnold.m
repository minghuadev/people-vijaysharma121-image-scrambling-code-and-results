function r=iArnold(c,n)
L=size(c);
K=[1 1;1 2]; % for Arnold Transformation
% K = [2 -1;-1 1]; % for Anti Arnold Transformation
K=inv(K);
for k=1:n
    for i=0:L(1)-1
        for j=0:L(2)-1
            loc=mod(K*[i j]',[L(1) L(2)]');
            r(loc(1)+1,loc(2)+1)=c(i+1,j+1);
        end
    end
    c=r;
end