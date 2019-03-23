function [x_sliced,t_sliced] = plotHarc(t,j,x,jstar,modificator,flag)
%PLOTHARC   Hybrid arc plot (n states).
%   PLOTHARC(t,j,x) plots hybrid time vector (t,j) versus vector (matrix) x
%   taking into account jumps j. If x is a matrix, then the vector is
%   plotted versus the rows or columns of the matrix, whichever line up.
%
%   plotHarc(t,j,x,jstar) plots hybrid time vector (t,j) versus vector x
%   taking into account jumps j, and the plot is cut regarding the jstar
%   interval (jstar = [j-initial j-final]).
%
%   plotHarc(t,j,x,jstar,modificator) plots hybrid time vector (t,j) versus
%   vector x taking into account jumps j, and the plot is cut regarding the
%   jstar interval (jstar = [j-initial j-final]). Modificator must be a
%   cell array that contains the standard matlab ploting modificators (see
%   example)
%
%   Various line types, plot symbols and colors may be obtained with
%   plotHarc(t,j,x,jstar,modificator) where modificator is a cell array
%   created with the following strings:
%
%          b     blue          .     point              -     solid
%          g     green         o     circle             :     dotted
%          r     red           x     x-mark             -.    dashdot 
%          c     cyan          +     plus               --    dashed   
%          m     magenta       *     star             (none)  no line
%          y     yellow        s     square
%          k     black         d     diamond
%          w     white         v     triangle (down)
%                              ^     triangle (up)
%                              <     triangle (left)
%                              >     triangle (right)
%                              p     pentagram
%                              h     hexagram
%                         
%
%   Example
%         % Load a hybrid arc
% 
%         load Data_Example_1_2_BB
% 
%         % Plot the hybrid arc Vs the hybrid time domain (t,j)
%         figure(1)
%         plotHarc(t,j,x);
%         xlabel('time')
%         ylabel('x_1, x_2')
%         grid on
% 
% 
%         % Plot the hybrid arc Vs the hybrid time domain (t,j) for a specified jump span $j\in[3,5]$
% 
%         figure(2)
%         plotHarc(t,j,x,[3,5]);
%         xlabel('time')
%         ylabel('x_1, x_2')
%         grid on
% 
%         % Plot and get the hybrid arc Vs the hybrid time domain (t,j) for a specified jump
% 
%         figure(3)
%         [x_sliced,t_sliced] = plotHarc(t,j,x,[5]);
%         xlabel('time')
%         ylabel('x_1, x_2')
%         grid on
% 
% 
%         % Use the modificators
%         figure(4)
%         modificator{1} = 'b';
%         modificator{2} = 'LineWidth';
%         modificator{3} = 3;
%         modificator{4} = 'Marker';
%         modificator{5} = 'p';
%         modificator{6} = 'MarkerEdgeColor';
%         modificator{7} = 'r';
%         modificator{8} = 'MarkerFaceColor';
%         modificator{9} = 'b';
%         modificator{10} = 'MarkerSize';
%         modificator{11} = 6;
% 
%         plotHarc(t,j,x(:,1),[],modificator);
%         xlabel('time')
%         ylabel('x_1, x_2')
%         hold on
%         grid on
% 
%         modificator{1} = 'g';
%         modificator{2} = 'LineWidth';
%         modificator{3} = 3;
% 
%         plotHarc(t,j,x(:,2),[],modificator);
% 
%         % Plot a phase plane e.g., $x_1$ Vs $x_2$
% 
%         figure(5)
%         plotHarc(x(:,1),j,x(:,2));
%         xlabel('x_1')
%         ylabel('x_2')
%         xlim([-0.1, 1])
%         grid on
%
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @ Hybrid Dynamics and Control Lab, 
% http://www.u.arizona.edu/~sricardo/index.php?n=Main.Software
% http://hybridsimulator.wordpress.com/
% Filename: plotHarc.m
%--------------------------------------------------------------------------
%   See also plotflows, plotHarc, plotHarcColor, plotHarcColor3D,
%   plotHybridArc, plotjumps.
%   Copyright @ Hybrid Dynamics and Control Lab,
%   Revision: 0.0.0.1 Date: 04/23/2014 10:48:24



switch nargin
    case 3
        iini = j(1);
        ifini = j(end);
        modificator{1} = '';
    case 4
        iini = jstar(1);
        try
            ifini = jstar(2);
        catch
            ifini = jstar(1);
        end
        modificator{1} = '';
    case 5
        if isempty(jstar)
            iini = 0;
            ifini = j(end);
        else
            iini = jstar(1);
            try
                ifini = jstar(2);
            catch
                ifini = jstar(1);
            end
        end
        flag=1;
    
end
nt = length(t);
[rx,cx] = size(x);
if rx == nt
    x = x;
elseif cx == nt
    x = x';
else
    fprintf('Error, x does not have the proper size')
    return
end
x_sliced{ifini-iini+1} = [];
t_sliced{ifini-iini+1} = [];
for ij=1:ifini-iini+1
    iij = find(j(:)==iini+ij-1,1,'first');
    fij = find(j(:)==iini+ij-1,1,'last');
    x_sliced{ij} = x(iij:fij,:);
    t_sliced{ij} = t(iij:fij);
    plot(t_sliced{ij},x_sliced{ij},modificator{1:end});
    hold on;
    if ij>1
        plot(t(iij-1:iij),x(iij-1:iij,:),...
            [':.',modificator{1}],modificator{2:end});
    end
end
hold off;
