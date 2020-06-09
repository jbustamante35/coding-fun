 yi = 2;
 for i = 1 : 10
    x = sin(1 : i : i*100);
    y = cos(1 : yi : yi*100);
    z = tan(1 : yi+i : (yi+i)*100);
    plot3(x,y,z, 'Marker', '.', 'MarkerSize', 10, 'LineStyle', 'none');
    pause(0.4);
end