%----------Scrambeling--------------------
%
%
%

%--------initialisation-------------------

%-----k is coordination of images------------
%-----actually k = wigth+heigth or is equal to 2n in 2^n * n^2 images
%----calculate k value in each image
% ------for all images , that is calculated its k value

function [Scrambeled_position]= scrmbl(imCvr)
tic;
disp('Please wait for Partitioning and Scrambeling ...');  
   [new_position]=Partition(0,imCvr); %function Partition(0), initialization.
 Dim=size(imCvr);
 %% Cnot gate ..............................
      
      for j=2:2.0:Dim(2)
          for i=1:2.0:Dim(1)
              
      if mod(j,2) == 0        % even
         % swap pair cells
         t=new_position(j,i);
         new_position(j,i)=new_position(j,i+1);
         new_position(j,i+1)=t;
         % swap pair cells
         
      end
          end
      end
 %% Cnot gate ................................
      
%-------Partitioning with Odd & Even%functions-----------------------------%
Dim=size(imCvr);
       
 for i=1:log2(Dim(1))-1          
     
  

        if i < log2(Dim(1))-1
          %%  re partitioning ... 
         [P_Matrix]= P_Matrix(i,new_position);    % 512 to 256   (Blocking ...) 
         [P_Matrix]=Partition(0,P_Matrix);    
         [new_position]= Reverse_P_Matrix(i,P_Matrix,Dim(1)); % 256 to 512 
        
        end
            
         
         if mod(i,2)==1       % odd
             
             % odd func
              [new_position] = odd(i, new_position);
                       
                            
         else                 %even

             % even func
              [new_position] = Even(i,new_position);            
             
             
         end
                
        
  end
       

Scrambeled_position = new_position;
toc;

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
    
