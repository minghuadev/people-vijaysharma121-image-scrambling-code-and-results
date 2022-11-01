function [s]= xorbin(A,B)

    if A=='0' && B =='1'
    
        s='1';
    
    elseif A=='0' && B=='0'
       
            s= '0';
            
        elseif A=='1' && B=='1'
                
                s='0';
                
            elseif A=='1' && B=='0'
                
                s='1';
    end
            


end
