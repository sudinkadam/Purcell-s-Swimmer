function next_pos=return_next_pos(curr_pos,xi,dt)

curr_pos_SE2= [cos(curr_pos(3)),   -sin(curr_pos(3)),   curr_pos(1);
               sin(curr_pos(3)),    cos(curr_pos(3)),   curr_pos(2);
                              0,                   0,              1];

lie_alg=[0,     -xi(3),     xi(1);
         xi(3),      0,     xi(2);
         0,          0,         0];

next_pos_SE2=expm(lie_alg*dt)*curr_pos_SE2;

next_pos=[next_pos_SE2(1); next_pos_SE2(2); atan2(next_pos_SE2(2,2),next_pos_SE2(1,1))];