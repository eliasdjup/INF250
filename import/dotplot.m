function varargout = dotplot(X,ax)
% FUNCTION TO DRAW A DOTPLOT OF A VECTOR OF DATA.
%
% dotplot(X) produces a dotplot of data in vector X in a new figure.
% dotplot(X,ax) produces a dotplot of X data in the axes with handle ax.
% h = dotplot(...) produces the dotplot and gives it handle h.
%
% The data points in X are drawn as small boxes, according to the following
% rules:
%   -Each box must be centered at its true x-value (no binning).
%   -The boxes are plotted in sequence from the minimum x-value to the max.
%   -No two boxes may overlap.
%   -If a box overlaps one that has already been plotted, then the box is 
%    shifted up by one box-height at a time until there is no overlap.


n = length(X);                          %-Sort the data, etc.
X = sort(X);
minX = X(1);
maxX = X(n);
R = maxX-minX;

                                        %-Determine dot width.
c = 100;                                %-Constant c is max number of boxes that 
                                        % could be plotted side-by-side.
w = (R/(c-1))/2;                        %-w is the half-width of each box.
% w = sqrt(1/(n*4));                      %-Set w to this to make total area = 1.

Y = 3*w*ones(n,1);                      %-Initialize y-levels for all boxes.
VX = zeros(4,n);                        %-Matrix VX holds x-coords of vertices.
VY = zeros(4,n);                        % Matrix VY holds y-coords of vertices.
                                        % Each VX/VY column pair defines the
                                        % vertices of one box.

                                        %-Set up the vertices of the box for
                                        % the first point.
VX(:,1) = [X(1)-w X(1)+w X(1)+w X(1)-w]';
VY(:,1) = [Y(1)-w Y(1)-w Y(1)+w Y(1)+w]';

                                        %-Figure out the y-levels for boxes 2
 for i = 2:n                            % through n.

                                        %-Check to see if left edge of dot i 
                                        % overlaps right edge of a previous dot 
                                        % on the same y-level.
    comparators = Y(1:i-1)==Y(i);
    if sum(comparators)>0 && X(i)-w < max(X(comparators)+w)
        overlaps = true;
    else
        overlaps = false;
    end
    
    while overlaps == true              %-While overlap still exists, shift up.
        Y(i) = Y(i)+2*w;
        comparators = Y(1:i-1)==Y(i);   %-Check for remaining overlaps
        if sum(comparators)>0 && X(i)-w < max(X(comparators)+w)
            overlaps = true;
        else
            overlaps = false;
        end
    end
                                        %-Store coords of vertices for ith box.
    VX(:,i) = [X(i)-w X(i)+w X(i)+w X(i)-w]';
    VY(:,i) = [Y(i)-w Y(i)-w Y(i)+w Y(i)+w]';
 end

if nargin==1                            %-Create the figure if necessary, then
    fig = figure();                     % plot all of the boxes.
    set(fig,'Position',[100 100 800 200],'Color','w')
    h = patch(VX,VY,[0.5 0.5 0.5]);     
                                        %-Change plot attrib (if plot into new axis).
    set(gca,'YTick',[], ...
            'YColor','w', ...
            'DataAspectRatio',[1 1 1], ...
            'TickDir','out')
else                                    %-Otherwise plot boxes in the current axes.
    h = patch(VX,VY,[0.5 0.5 0.5],'Parent',ax); 
    
end

if nargout==1
    varargout{1} = h;
end

