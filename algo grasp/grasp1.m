function [best_ring,best_star_mat,best_star,best_value] = grasp1(cost_ring, cost_star,time)
    tic;
    N=length(cost_ring);
    best_ring=[];
    best_star=[];
    best_star_mat=rand(N,N);
    best_value=Inf 

    N=length(cost_ring);
    ring = [1];
    star = [];
    possible = 2:N;
    p = 1;
    t=0;
    k=1;
    x=0;
    bestsol=0;
    sol=[];

    while t < time
      
      for alpha=0:0.01:0.4
        disp('grasp')
        ring = [1];
        star = [];
        possible = 2:N;

        while length(ring) + length(star) < N
          maximum = 0;
          minimum = inf;
          for i = possible
                if cost_ring(p, i) > maximum
                    maximum = cost_ring(p, i);
                endif

                if cost_star(p, i) > maximum
                    maximum = cost_star(p, i);
                endif

                if cost_ring(p, i) < minimum
                    minimum = cost_ring(p, i);
                endif

                if cost_star(p, i) < minimum
                    minimum = cost_star(p, i);
                endif

          endfor
          borne = minimum + (maximum - minimum) * alpha;

          options = [];
          counta = -1;

          for i = possible
                if cost_ring(p, i) <= borne
                    options(end+1)=i;
                    counta += 1;
                endif
          endfor
          for i = possible
                if cost_star(p, i) <= borne
                    options(end+1)=i;
                endif
          endfor
          if length(options) > 1
                r = randi(length(options));
          else
                r = 1;

          endif
          for j =1:length(possible)
                if j>length(possible)
                  break;
                endif
                if possible(j) == options(r)
                    possible(j)=[];
                    j-=1;
                endif

          endfor

          if r < counta
                ring(end+1)=options(r);
                p = options(r);

          else
                star(end+1)=options(r);
          endif
        endwhile

         star_mat = assignement (star,cost_star,ring);

         cout1 = cout(cost_ring,cost_star,ring,star_mat);
         
         if cout1<best_value  
           best_ring=ring;
           best_star=star;
           best_star_mat=star_mat;
           best_value=cout1
         endif 

##         do 
##           [ring ,star_mat,star]=Meilleur_Voisin(cost_ring,cost_star,ring,star_mat,star);
##            new_cout = cout(cost_ring,cost_star,ring,star_mat)
##           if cout1<best_value  
##             best_ring=ring;
##             best_star=star;
##             best_star_mat=star_mat;
##             best_value=cout1
##           else
##             break 
##           endif 
##            
##         until new_cout>best_value
       end 


        

    t=toc ;
    endwhile


endfunction

