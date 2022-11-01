function c=Arnold(o,n)
L=size(o);
K=[1 1;1 2]; % for Arnold Transformation
% K = [2 -1;-1 1]; % for Anti Arnold Transformation
for k=1:n
    for i=0:L(1)-1
        for j=0:L(2)-1
            loc=mod(K*[i j]',[L(1) L(2)]');
            c(loc(1)+1,loc(2)+1)=o(i+1,j+1);
        end
    end
    o=c;
end