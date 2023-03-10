% GINI calcula el coeficiente de Gini y la curva de Lorentz.
%
% Usage:
%   g = gini(pop,val)
%   [g,l] = gini(pop,val)
%   [g,l,a] = gini(pop,val)
%   ... = gini(pop,val,makeplot)
%
% Input and Output:
%   pop     A vector of population sizes of the different classes.
%   val     A vector of the measurement variable (e.g. income per capita)
%           in the diffrerent classes.
%   g       Gini coefficient.
%   l       Lorentz curve: This is a two-column array, with the left
%           column representing cumulative population shares of the
%           different classes, sorted according to val, and the right
%           column representing the cumulative value share that belongs to
%           the population up to the given class. The Lorentz curve is a
%           scatter plot of the left vs the right column.
%   a       Same as l, except that the components are not normalized to
%           range in the unit interval. Thus, the left column of a is the
%           absolute cumulative population sizes of the classes, and the
%           right colun is the absolute cumulative value of all classes up
%           to the given one.
%   makeplot  is a boolean, indicating whether a figure of the Lorentz
%           curve should be produced or not. Default is false.
%
% Example:
%   x = rand(100,1);
%   y = rand(100,1);
%   gini(x,y,true);             % random populations with random incomes
%   figure;
%   gini(x,ones(100,1),true);   % perfect equality
%
% Explanation:
%
%   The vectors pop and val must be equally long and must contain only
%   positive values (zeros are also acceptable). A typical application
%   would be that pop represents population sizes of some subgroups (e.g.
%   different countries or states), and val represents the income per
%   capita in this different subgroups. The Gini coefficient is a measure
%   of how unequally income is distributed between these classes. A
%   coefficient of zero means that all subgroups have exactly the same
%   income per capital, so there is no dispesion of income; A very large
%   coefficient would result if all the income accrues only to one subgroup
%   and all the remaining groups have zero income. In the limit, when the
%   total population size approaches infinity, but all the income accrues
%   only to one individual, the Gini coefficient approaches unity.
%
%   The Lorenz curve is a graphical representation of the distribution. If
%   (x,y) is a point on the Lorenz curve, then the poorest x-share of the
%   population has the y-share of total income. By definition, (0,0) and
%   (1,1) are points on the Lorentz curve (the poorest 0% have 0% of total
%   income, and the poorest 100% [ie, everyone] have 100% of total income).
%   Equal distribution implies that the Lorentz curve is the 45 degree
%   line. Any inequality manifests itself as deviation of the Lorentz curve
%   from the  45 degree line. By construction, the Lorenz curve is weakly
%   convex and increasing.
%
%   Los dos conceptos se relacionan de la siguiente manera: El coeficiente
%   de Gini es el doble del área entre la línea de 45 grados y la curva 
%   de Lorentz.
%
% Author : Yvan Lengwiler
% Release: $1.0$
% Date   : $2010-06-27$

function [g,l,a] = gini(pop,val,makeplot)

    % verificar argumentos

    assert(nargin >= 2, 'Gini espera al menos dos argumentos.')

    if nargin < 3
        makeplot = false;
    end
    assert(numel(pop) == numel(val), ...
        'gini espera dos vectores de igual tamaño (%d ~= %d).', ...
        size(pop,1),size(val,1))

    pop = [0;pop(:)]; val = [0;val(:)];     % añadir previamente un cero

    isok = all(~isnan([pop,val]'))';        % filtrar salidas NaNs
    if sum(isok) < 2
        warning('gini:lacking_data','not enough data');
        g = NaN; l = NaN(1,4);
        return;
    end
    pop = pop(isok); val = val(isok);
    
    assert(all(pop>=0) && all(val>=0), ...
        'gini espera vectores no negativos (neg elements in pop = %d, in val = %d).', ...
        sum(pop<0),sum(val<0))
    
    % entrada de proceso
    z = val .* pop;
    [~,ord] = sort(val);
    pop    = pop(ord);     z    = z(ord);
    pop    = cumsum(pop);  z    = cumsum(z);
    relpop = pop/pop(end); relz = z/z(end);
    
    % Coeficiente de Gini

    % Calculamos el área debajo de la curva de Lorentz. Hacemos esto 
    % calculando el promedio de las sumas tipo Riemann izquierda y derecha.
    % (Se dice Riemann-'like' porque evaluamos no en una cuadrícula 
    % uniforme, sino en los puntos dados por los datos emergentes).
    %
    % Estas son las dos sumas tipo Rieman:
    %    leftsum  = sum(relz(1:end-1) .* diff(relpop));
    %    rightsum = sum(relz(2:end)   .* diff(relpop));
    % El coeficiente de Gini es uno menos el doble del promedio de la suma 
    % izquierda y la suma derecha. Podemos poner todo esto en una línea.
    g = 1 - sum((relz(1:end-1)+relz(2:end)) .* diff(relpop));
    
    % Curva de Lorentz
    l = [relpop,relz];
    a = [pop,z];
    if makeplot   % ... ¿trazarlo?
        area(relpop,relz,'FaceColor',[0.5,0.5,1.0]);    % la curva de Lorentz
        hold on
        plot([0,1],[0,1],'--k');                        % línea de 45 grados
        axis tight      % rangos de abscisas y ordenadas son por definición exactamente [0,1]
        axis square     % ambos ejes deben tener la misma longitud
        set(gca,'XTick',get(gca,'YTick'))   % garantizar la igualdad de tic-tac (ticking)
        set(gca,'Layer','top');             % cuadrícula sobre el área sombreada
        grid on;
        title(['\bfGini coefficient = ',num2str(g)]);
        xlabel('share of population');
        ylabel('share of value');
    end
    
end
