function [P_Matrix]=odd(k,Dimen)

   
   Dim= size(Dimen);
   for j=1:Dim(2)
       for i=1:Dim(1)
           
          X=dec2bin(i-1,log2(Dim(1)));
          Y=dec2bin(j-1,log2(Dim(2)));
           
          % step1
           [IX]=inverse_bit(X);
           [IY]=inverse_bit(Y);
           
           % swap Yk with Xk
            [IY(k+1),IX(k+1)]=Swp(IX(k+1),IY(k+1));
            
            if IX(k+1)=='1'
               IY(k+1)=xorbin(IX(k+1),IY(k+1)); 
            end
            
             % step2
             
            if IY(k+1)=='1'
                for m=1:k
                    [IY(m),IX(m)]=Swp(IX(m),IY(m));
                end
            end
             
             % step3
              
             if IX(k+1)=='1' && IY(k+1)=='0'
                 for m=1:k
             
                   IY(m)= xorbin(IY(m),IX(k+1));   
                   IX(m)= xorbin(IX(m),IX(k+1));
                 
                 end
             end
             
           [X]=inverse_bit(IX);
           [Y]=inverse_bit(IY);
     
           %%%%%%%%%

     w= bin2dec(Y)+1;
     l= bin2dec(X)+1;
     P_Matrix(w,l)=Dimen(j ,i);
                 
       end
    end
end

function [output]=inverse_bit(input)
   m=length(input);
    output=dec2bin(0,m);
     for n=1 : m      
         output(n)= input(m);
         m=m-1;
     end

end

function [B,A]=Swp(A,B)
    
    t=A;
    A=B;
    B=t;

end