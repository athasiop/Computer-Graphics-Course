function color = colorInterp(A,B,a,b,x)
%Sioppidis Athanasios 9090

%A=color of point a
%B= color of point b
%x = pixel we want to interpolate on
%da = distance from x to point a
%db = distance from x to point b
   
   if x-a==0&&x-b==0
      color = A;  
       return
   end
    
    da = abs(x-a);
    db = abs(b-x);
    
    x = (da/(da+db))*B+(db/(da+db))*A;
    color = x;
 

                        

end

