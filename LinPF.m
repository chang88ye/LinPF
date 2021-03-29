%% to generate PF of linPF
%

testID=6;

% generate obtainable objective space
p=ones(3,1)/3;
[x,y]=meshgrid(0:0.02:1);
switch testID
    case 1,
        % CASE 1: eclipse
        y=2*pi*y;
        p=ones(1,3)/3;
        f3=(p(1)+x.*cos(y)-x.*sin(y))+3;
        f2=p(2)+x.*cos(y)+x.*sin(y)+2;
        f1=p(3)-x.*cos(y)+1;

    case 2,
        % Case 2: thin ring
        y=pi*y*4;
        x=0.2*x+0.8;
        f3=p(1)+x.*cos(y)-x.*sin(y)+3;
        f2=p(2)+x.*cos(y)+x.*sin(y)+2;
        f1=p(3)-x.*cos(y)+1;

    case 3,
        % Case 3: incomplete ring
        y=pi/2*y+2*pi;
        x=0.5*(x+1);
        f3=p(1)+x.*cos(y)-x.*sin(y)+3;
        f2=p(2)+x.*cos(y)+x.*sin(y)+2;
        f1=p(3)-x.*cos(y)+1;
    case 4,
        % Case 4: S curve
        y=pi*(y/2+1/4);
        x=0.2*(x+4);
        f3=p(1)+x.*cos(y)-x.*sin(y.^2)+3;
        f2=p(2)+x.*cos(y)+x.*sin(y.^2)+2;
        f1=p(3)-x.*cos(y)+1;
    case 5,
        % Case 5: eclipse + ring
        y=2*pi*y;
        g=(1+sin(pi/2*round(2*x)));
        f3=(p(1)+x.*cos(y)-x.*sin(y)+3).*g;
        f2=(p(2)+x.*cos(y)+x.*sin(y)+2).*g;
        f1=(p(3)-x.*cos(y)+1).*g;
        Ind=2*f1+f2+f3>25.1/3;
        f1(Ind)=nan;
        f2(Ind)=nan;
        f3(Ind)=nan;
    case 6,
        % Case 6: eclispe + curve
        y=2*pi*y;
        g=(1+sin(pi/2*floor(2*x+0.04)));
        f3=(p(1)+x.*cos(y)-x.*sin(y)+3).*g;
        f2=(p(2)+x.*cos(y)+x.*sin(y)+2).*g;
        f1=(p(3)-x.*cos(y)+1).*g;
        Ind=2*f1+f2+f3>25.01/3;
        f1(Ind)=nan;
        f2(Ind)=nan;
        f3(Ind)=nan;
        
    otherwise,
        error('test problem is not defined yet')
end

mesh(f1,f2,f3,  'FaceColor',[0,0.45,0.75], 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('\itf\rm_1','FontSize',24,'FontName','Times New Roman')
ylabel('\itf\rm_2','FontSize',24,'FontName','Times New Roman')
zlabel('\itf\rm_3','FontSize',24,'FontName','Times New Roman')

% set font size for ticklabels
ax=gca;
ax.FontSize=20;
grid on

set(gcf,'color','w');

view(130,30)