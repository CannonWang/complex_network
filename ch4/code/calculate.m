function [c d] = calculate(p)

%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description


N=300;
degree = 6;
% break_p = [0, power(10,(-4:0.1:0)), 1];

connection = zeros(N,N);
for i = 1:degree/2
    connection = connection + diag(ones(1,N-i),i) + diag(ones(1,i),N-i);
end

reconnection = connection .*rand(N,N);

for row = 1:N-1
    for column = row+1:N
        if((reconnection(row, column) > 0) && (reconnection(row, column) < p))
            reconnection(row, column) = 0;
            
            while(1)
                new_connection = randi([1 N],1);
                
                if((new_connection ~= row) && (reconnection(row, new_connection) == 0) && (reconnection(new_connection, row) == 0))
                    reconnection(new_connection, row) = 1;
                    reconnection(row, new_connection) = 1;
                    break;
                end
            end
        end
    end
end


reconnection = triu(reconnection);
reconnection = ceil(reconnection);
reconnection = reconnection + reconnection';

% reconnection



%求一个网络的平均【最短距离路径】：节点对之间距离之和/节点对数目。
%其中，不可达两点距离为0，节点自身与自身距离为0，节点对数目为(N*(N-1)/2)
D = reconnection;   %D为距离矩阵
D(find(D==0))=inf;
for k=1:N       %Floyd算法求解任意两点的最短距离    
    for e=1:N 
        for f=1:N 
             if D(e,f)>D(e,k)+D(k,f)   
                    D(e,f)=D(e,k)+D(k,f); 
             end
        end
    end
D(k,k)=0;
end
D(find(D==inf))=0;
average_shortest_path_length =(sum(D(:))/2)/(N*(N-1)/2);


%求一个网络的平均集聚系数：所有节点的CC之和/节点数目
%一个节点的CC=邻居实际相连的边/邻居间应该相连的边=邻居实际相连的边/（di*（di-1）/2）
%其中，di为节点i的度
%所以，算节点CC的方法二：以节点i的邻居们为节点，构造子图。子图中1的数目的一半就是CC

con_matrix = reconnection;
sum_CC = zeros(N,1);
a_CC = zeros(N,1);

for k=1:N 
    num_k=sum(con_matrix(k,:));
    
    if num_k==0||num_k==1   %若节点i度为0或1，则其没有CC
        sum_CC(k)=0;
    else
        for e=1:N 
            for f=e+1:N 
                if con_matrix(k,e)+con_matrix(k,f)==2 && con_matrix(e,f)==1 
                   sum_CC(k)=sum_CC(k)+1;
                end
            end
        end
    a_CC(k)=sum_CC(k)/((num_k)*(num_k-1)/2);    
    end
end
ave_CC = sum(a_CC)/N;

c = ave_CC;
d = average_shortest_path_length;




% 
% %形成N个点
% position=zeros(N,2);
% for m=1:N
%     position(m,1)=cos(m*2*pi/N);
%     position(m,2)=sin(m*2*pi/N);
% end
% 
% %画出N个点
% plot(position(:,1),position(:,2),'o')
% hold on
% for i=1:N
%     for j=i:N
%         if(connection(i,j) == 1)
%             plot(position([i,j],1),position([i,j],2));
%         end
%     end
% end
