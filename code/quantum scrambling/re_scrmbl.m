%----------reverse Scrambeling------------
%
%
%

function [stego_position] = re_scrmbl(emb_position)

    %  inverse scrambeling ...
    disp('Please wait for rinverse scrambeling ... '); 
      new_inverse_position=emb_position;
      for i=log2(size(emb_position,1))-1:-1:1
        
        if mod(i,2) ==1  % odd
            [new_inverse_position] = inverse_odd(i,new_inverse_position);
        else             % even 
            [new_inverse_position] = inverse_even(i,new_inverse_position);
        end
       if i<log2(size(emb_position,1))-1
               %%  re partitioning ... 
        [P_Matrix]= P_Matrix(i,new_inverse_position);    % 512 to 256   (Blocking ...) 
        [P_Matrix]= inv_partition(0,P_Matrix);    
        [new_inverse_position]= Reverse_P_Matrix(i,P_Matrix,size(emb_position,1)); % 256 to 512 
     
       end
                 
     end
    
    % at the end of the re_scrambeling phase, I do Cnot gate and so doing
    % the re_partition(0) for finish this function.
    
     %% Cnot gate ...
       for j=2:2.0:size(emb_position,2)
          for i=1:2.0:size(emb_position,1)
            
                if mod(j,2) == 0        % even
         % swap pair cells
                    t=new_inverse_position(j,i);
                    new_inverse_position(j,i)=new_inverse_position(j,i+1);
                    new_inverse_position(j,i+1)=t;
         % swap pair cells
                end
              
          end
       end
     
     
     %% so doing of re_partition(0) ...
     % return Stego image ... 
       [stego_position] = inv_partition(0,new_inverse_position);
          
end

 function [P_Matrix]= P_Matrix(k,new_position)
        
        row=1;
        col=1;
        
         
        for j=1:(2^k):length(new_position)
            for i=1:(2^k):length(new_position)
        
                P_Matrix{col,row} = new_position(j:j+(2^k)-1,i:i+(2^k)-1);
                
                row=row+1;
            end
            row=1;
            col=col+1;
            
        end
        
    
    end
    function [new_position]= Reverse_P_Matrix(k,P_Matrix,Dim)
        
        row=1;
        col=1;
        
        for j=1:(2^k):Dim
            for i=1:(2^k):Dim
        
                new_position(j:j+(2^k)-1,i:i+(2^k)-1)=P_Matrix{col,row}; 
                
                row=row+1;
            end
             row=1;
            col=col+1;
            
        end
        
    
    end
    
