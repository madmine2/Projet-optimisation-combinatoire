## Copyright (C) 2022 alexi
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} Supression (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: alexi <alexi@LAPTOP-OIJ9MENO>
## Created: 2022-12-04

function [best_ring,best_star_mat,best_star]=Supression(cost_ring,cost_star,listering,listestar,star)
  N=length(listering);
  num=randi(N);
  
  best_ring=listering;
  best_star=star;
  best_star_mat=listestar;
  best_valeur=Inf;
  centre_star=listering(num);
  elem_star=extrait_star(centre_star,listestar);
  
  % supression 
  new_listering=listering;
  new_listering(num)=[];
  new_star=star;
  new_star(end+1)=centre_star;
  newlistestar= assignement (new_star,cost_star,new_listering);
  new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
         disp("suppression")
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
endfunction
