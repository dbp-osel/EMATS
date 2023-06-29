function names=PreDREEGd(F,p)
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