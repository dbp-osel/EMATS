function names=PreDREEGd(F,p)
%PREDREEGd Selects and plots the tSNE points in F (dreegstruc) at
% percentage p (default = 0.5) away from the center of mass. Names output
% denotes selected points.
%
%   Authors:
%       Michael Caiola (Michael.Caiola@fda.hhs.gov)
%       Meijun Ye (Meijun.Ye@fda.hhs.gov)
%
%   Disclaimer: This software and documentation (the "Software") were 
%   developed at the Food and Drug Administration (FDA) by employees of
%   the Federal Government in the course of their official duties.
%   Pursuant to Title 17, Section 105 of the United States Code,
%   this work is not subject to copyright protection and is in the
%   public domain. Permission is hereby granted, free of charge, to any
%   person obtaining a copy of the Software, to deal in the Software
%   without restriction, including without limitation the rights to
%   use, copy, modify, merge, publish, distribute, sublicense, or sell
%   copies of the Software or derivatives, and to permit persons to
%   whom the Software is furnished to do so. FDA assumes no
%   responsibility whatsoever for use by other parties of the Software,
%   its source code, documentation or compiled executables, and makes
%   no guarantees, expressed or implied, about its quality,
%   reliability, or any other characteristic. Further, use of this code
%   in no way implies endorsement by the FDA or confers any advantage
%   in regulatory decisions. Although this software can be
%   redistributed and/or modified freely, we ask that any derivative
%   works bear some notice that they are derived from it, and any
%   modified versions bear some notice that they have been modified.

if nargin < 2
    p = 0.5;
end
if and(p>1,p<=100)
    p=p/100;
elseif p>100
    error("p must be less than 1")
end
y=ClusterCohesion(F.out.Z);
[~,x]=sort(y);
x1=x(1:floor(end*p));
x2=x(floor(end*p)+1:end);
figure
%scatter3(F.out.Z(x2,1),F.out.Z(x2,2),F.out.Z(x2,3),15,'k','filled','MarkerFaceAlpha','flat','AlphaData',repmat(.001,[1,length(x2)]));
scatter3(F.out.Z(x2,1),F.out.Z(x2,2),F.out.Z(x2,3),15,'k','MarkerEdgeAlpha','flat','AlphaData',repmat(.001,[1,length(x2)]));
hold on
scatter3(F.out.Z(x1,1),F.out.Z(x1,2),F.out.Z(x1,3),15,y(x1),'filled');
caxis([min(y),max(y)])
title("Cluster and Outliers")
figure
scatter3(F.out.Z(x1,1),F.out.Z(x1,2),F.out.Z(x1,3),15,y(x1),'filled');
caxis([min(y),max(y)])
title("Cluster")
names=F.out.allnames(x1,:);

function y=ClusterCohesion(x)
y=zeros(length(x),1);
for i=1:length(y)
    a=1:length(y);
    a(i)=[];
    for j=a
        y(i)=y(i)+norm(x(i,:)-x(j,:));
    end
    y(i)=y(i)*1/(length(y)-1);
end