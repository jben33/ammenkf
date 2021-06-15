% Input values and mesh points
% Outputs valid mesh and new values at those mesh points

function [nvals, nmesh] = remesh(pvals, pmesh)

global left right d1 d2

%% First, get the new valid mesh

len = length(pmesh);        % current length of mesh
cmesh = pmesh;              % store the old mesh for interpolation later

% Error checking
if(length(pmesh) < 1)
    msg = 'Mesh too small!';
    error(msg)
end

% Periodicity for points too far left
while(pmesh(1) < left)
    rmesh = pmesh(2:len);
    pmesh = rmesh;
    len = length(pmesh);
end

% Error checking
if(len > length(pmesh))
    msg = 'len is too big';
    error(msg)
end

% Periodicity for points too far right
while(pmesh(len) > right && len >= 1)
    lmesh = pmesh(1:len-1);
    pmesh = lmesh;
    len = length(pmesh);
end
len = length(pmesh);

i = 1;                      % iterator

% Remove points that are too close together
while (i < len)
    a = pmesh(i);
    b = pmesh(i+1);
    while(b-a < d1)         % check whether mesh points a and b are too close together
        lmesh = pmesh(1:i);
        if(i+1 < len)
            rmesh = pmesh(i+2:len);
            b = pmesh(i+2);
        else
            rmesh = [];
            b = 100;
        end
        pmesh = [lmesh rmesh];
        len = length(pmesh);
    end
    i = i+1;
    len = length(pmesh);
end

len = length(pmesh);
i = 1;

% Add points halfway between points that are too far apart
while (i < len)
    a = pmesh(i);
    b = pmesh(i+1);
    while (b-a > d2)
        np = (a+b)/2;
        lmesh = pmesh(1:i);
        rmesh = pmesh(i+1:len);
        pmesh = [lmesh np rmesh];
        b = np;
        len = length(pmesh);
    end
    len = length(pmesh);
    i = i+1;
end

% Check endpoints
len = length(pmesh);
b = pmesh(1);
a = pmesh(len);
while(b-left+right-a < d1)
    rmesh = pmesh(2:len);
    pmesh = rmesh;
    len = length(pmesh);
    b = pmesh(1);
    a = pmesh(len);
end
len = length(pmesh);
b = pmesh(1);
a = pmesh(len);
while(b-left+right-a > d2)
    np = (right+b+a)/2;
    if (np > right)
        np = np-right+left;
        rmesh = pmesh;
        pmesh = [np rmesh];
    else
        lmesh = pmesh;
        pmesh = [lmesh np];
    end
    len = length(pmesh);
    b = pmesh(1);
    a = pmesh(len);
end

nmesh = pmesh;

%% Next, get the new values at the new mesh points

nm = nmesh;

nmLen = length(nm);
if (nm(1) < left)
    tempMesh = nm(2:nmLen);
    np = right-left+nm(1);
    nm = [tempMesh np];
end
if (nm(nmLen) > right)
    tempMesh = nm(1:nmLen-1);
    np = left+right-nm(nmLen);
    nm = [np tempMesh];
end
omLen = length(cmesh);


%% obtain new values using interpolation
nvals = nan(1,nmLen);

% Loop through new mesh points, construct new values one at a time
for i=1:nmLen
    
    cp = nm(i);                                     % current new mesh point
    
    % Find new mesh point "within" old mesh
    leftmost = cmesh(1);
    rightmost = cmesh(omLen);
    if (cp < leftmost)                              % check if new mesh point is further left than leftmost old mesh point
        % set interpolation weights and L/R indices
        lInd = omLen;
        rInd = 1;
        a = leftmost-cp;
        b = cp-left+right-rightmost;
    elseif(cp > rightmost)                          % check if new mesh point is further right than rightmost old mesh point
        % set interpolation weights and L/R indices
        lInd = omLen;
        rInd = 1;
        a = leftmost-left+right-cp;
        b = cp-rightmost;
    else
        % find L/R indices
        j = omLen;
        while(cmesh(j) >= cp && j > 1)
            j = j-1;
        end
        lInd = j;
        rInd = j+1;
        if(abs(cmesh(lInd)-cp)<=0.001)
            a = 1;
            b = 0;
        elseif(abs(cmesh(rInd)-cp)<0.001)
            a = 0;
            b = 1;
        else
            a = cmesh(rInd)-cp;
            b = cp-cmesh(lInd);
        end
    end
    nvals(i) = a/(a+b)*pvals(lInd)+b/(a+b)*pvals(rInd);
    
end

