function theta = vectangle(u,v,dim,flg)
% The cosine of the angle between two vectors a & b is obtained by dividing
% the dot product of the two vectors by the product of their lengths:
%
%                         u'*v
%                 ------------------------
%                 sqrt(sum(u.^2)*sum(v.^2)
%
% If (and only if) both vectors have zero mean, i.e. sum(a)==sum(b)==0,
% then the cosine of the angle between the vectors is the same as the
% correlation between the two variates.
%
% The angle can be given as the cosine (flg = 'cos'),
% or in degrees (flg = 'deg').

if nargin < 4
    flg = 'cos';
end

if nargin < 3
    dim = 1;
end

% check if input is coming from 
siz = size(u);
if nargin < 2 || isempty(v)
    idx = find(siz==2);
    if length(idx) ~= 1
        error('LENVER:VectAngle:InputDim','One input matrix is given but the dimension over which to calculate the angle is unknown');
    else
        M = permute(u,[idx setdiff(1:length(siz),idx)]);
        siz(idx) = [];
        u = nan(siz); v = nan(siz);
        u(:) = M(1,:); v(:) = M(2,:);
        if idx < dim
            dim = dim - 1;
        end
    end
end

% make vectors in same dimension
if numel(u) == length(u) && numel(v) == length(v)
    u = u(:); v = v(:);
end

% try to use cellfun if dimensions do not match
if ~isequal(size(u),size(v))
    if numel(v) >= numel(u)
        theta = cellfun(@(vv) vectangle(u,vv),num2cell(v,dim));
    else
        theta = cellfun(@(uu) vectangle(v,uu),num2cell(u,dim));
    end
    return;
end

% this is the actual work
try
    theta = dot(u,v)/(norm(u)*norm(v));
catch
    theta = (u'*v)/(sqrt(sum(u.^2)*sum(v.^2)));
end

% return in radians or degrees
if isequal(flg(1),'d')
	theta = acos(theta)*180/pi;
end