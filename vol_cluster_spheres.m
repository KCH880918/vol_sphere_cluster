% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%  calculate the volume of two clustered particles
%  r1 is the radius of larger particles
%  r2 is the radius of smaller particles
%  di is the distance between two spheres
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear
clc

r1 = 1;
r2 = 0.75*r1;
di = r1 + 0.0*r2;
a_box = 2*r1;
h_box = r1+r2+di;
Vol_box = a_box^2*h_box;

center1 = [r1 r1 r1];
center2 = [r1 r1 r1+di];

for i = 1:100
% generate random coordinate of points
Num = 100000;  % number of points we want to generate
pc = rand(Num, 3);
pc(:,1) = pc(:,1).*a_box;
pc(:,2) = pc(:,2).*a_box;
pc(:,3) = pc(:,3).*h_box;

check_position = zeros(Num,1);
check_position = (((pc(:,1)-center1(1)).^2 + (pc(:,2)-center1(2)).^2 + (pc(:,3)-center1(3)).^2 <= r1^2) | ...
    ((pc(:,1)-center2(1)).^2 + (pc(:,2)-center2(2)).^2 + (pc(:,3)-center2(3)).^2 <= r2^2));

num_inside(i) = sum(check_position);
inside_ratio(i) = num_inside(i)/Num;

Vol_spheres(i) = Vol_box*inside_ratio(i);

end

aver_numinside = mean(num_inside);
aver_insideratio = mean(inside_ratio);
aver_Volsphere = mean(Vol_spheres);