% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%  calculate the volume of two clustered particles        %
%  r1 is the radius of larger particles                   %
%  r2 is the radius of smaller particles                  %
%  di is the distance between two spheres                 %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear
clc

r1 = 1;                             % radius of larger spheres
r2 = 0.75*r1;                       % radius of smaller spheres
di = r1 + 0.0*r2;                   % distance of two spheres
a_box = 2*r1;                       % width/length of the box
h_box = r1+r2+di;                   % height of the box
Vol_box = a_box^2*h_box;            % volume of the box

center1 = [r1 r1 r1];               % center coordinate of large sphere
center2 = [r1 r1 r1+di];            % center coordinate of small sphere

it_num = 100;                       % iteration numbers

for i = 1:100
    % generate random coordinate of points
    Num = 100000;                   % number of points we want to generate
    pc = rand(Num, 3);              % coordinate of Num number of points
    pc(:,1) = pc(:,1).*a_box;       % scale the coordinates
    pc(:,2) = pc(:,2).*a_box;
    pc(:,3) = pc(:,3).*h_box;

    check_position = zeros(Num,1);
    % check if the points are inside spheres, inside = 1, outside = 0
    check_position = (((pc(:,1)-center1(1)).^2 + (pc(:,2)-center1(2)).^2 + (pc(:,3)-center1(3)).^2 <= r1^2) | ...
                     ((pc(:,1)-center2(1)).^2 + (pc(:,2)-center2(2)).^2 + (pc(:,3)-center2(3)).^2 <= r2^2));

    num_inside(i) = sum(check_position);        % calculate the number of points inside the geometry
    inside_ratio(i) = num_inside(i)/Num;
    Vol_spheres(i) = Vol_box*inside_ratio(i);

end

% calculate the results for all the iterations
aver_numinside = mean(num_inside);
aver_insideratio = mean(inside_ratio);
aver_Volsphere = mean(Vol_spheres);