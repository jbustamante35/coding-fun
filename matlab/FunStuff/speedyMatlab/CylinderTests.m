%% Tests on efficient OOP principles in MATLAB
% <https://blogs.mathworks.com/loren/2012/03/26/considering-performance-in-object-oriented-matlab-code/>

%% SimpleCylinder
tic
C1 = SimpleCylinder;
for k = 1:1000
    C1(k).R = 1;
    C1(k).Height = k;
end
V = volume(C1);
toc

%% SlowCylinder
tic
C2 = SlowCylinder;
for k = 1:1000
    C2(k).R = 1;
    C2(k).Height = k;
end
A = volume(C2);
toc

%% NewCylinderA
tic
C3 = NewCylinder(ones(1,1000), 1:1000);
A = volume(C3);
toc

%% NewCylinderB
C4 = NewCylinder(10, 20);
tic
for k = 1:1000
    volume(C4);
end
toc

%% NewCylinderC
C5 = NewCylinder(ones(1,1000), 1:1000);
tic
volume(C5);
toc

%% NewCylinderD
CS1 = struct('R', 10, 'Height', 20);
tic
for k = 1:1000
    cylinderVolume(CS1);
end

toc
CS2 = struct('R', num2cell(ones(1,1000)), ...
    'Height', num2cell(1:1000));
tic
cylinderVolume(CS2);
toc

