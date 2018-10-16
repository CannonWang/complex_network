clear;
clc;

N=100;
connection = zeros(N,N);
degree = 4;
break_p = 0.1;

neighbor_conn = [[-degree/2:-1],[1:degree/2]];

for i=1:N
    for j=1:length(neighbor_conn)
        if(i+neighbor_conn(j)<1)
            connection(i, i+neighbor_conn(j)+N) = 1;
        elseif(i+neighbor_conn(j)>N)
            connection(i, i+neighbor_conn(j)-N) = 1;
        else
            connection(i, i+neighbor_conn(j)) = 1;
        end
    end
end

for i=1:N
    for j=i:N
        if(connection(i,j) == 1)
            if(rand(1,1) < break_p)
                connection(i,j) = 0;
                connection(j,i) = 0;

                new_conn = round(rand(1,1) * (N-1));

                if(new_conn < i)
                    connection(i,new_conn) = 1;
                    connection(new_conn,i) = 1;
                else
                    connection(i,new_conn + 1) = 1;
                    connection(new_conn + 1,i) = 1;
                end  
            end
        end
    end
end

%形成N个点
position=zeros(N,2);
for m=1:N
    position(m,1)=cos(m*2*pi/N);
    position(m,2)=sin(m*2*pi/N);
end

%画出N个点
plot(position(:,1),position(:,2),'o')
hold on
for i=1:N
    for j=i:N
        if(connection(i,j) == 1)
            plot(position([i,j],1),position([i,j],2));
        end
    end
end
