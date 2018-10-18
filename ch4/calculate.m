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



%��һ�������ƽ������̾���·�������ڵ��֮�����֮��/�ڵ����Ŀ��
%���У����ɴ��������Ϊ0���ڵ��������������Ϊ0���ڵ����ĿΪ(N*(N-1)/2)
D = reconnection;   %DΪ�������
D(find(D==0))=inf;
for k=1:N       %Floyd�㷨��������������̾���    
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


%��һ�������ƽ������ϵ�������нڵ��CC֮��/�ڵ���Ŀ
%һ���ڵ��CC=�ھ�ʵ�������ı�/�ھӼ�Ӧ�������ı�=�ھ�ʵ�������ı�/��di*��di-1��/2��
%���У�diΪ�ڵ�i�Ķ�
%���ԣ���ڵ�CC�ķ��������Խڵ�i���ھ���Ϊ�ڵ㣬������ͼ����ͼ��1����Ŀ��һ�����CC

con_matrix = reconnection;
sum_CC = zeros(N,1);
a_CC = zeros(N,1);

for k=1:N 
    num_k=sum(con_matrix(k,:));
    
    if num_k==0||num_k==1   %���ڵ�i��Ϊ0��1������û��CC
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
% %�γ�N����
% position=zeros(N,2);
% for m=1:N
%     position(m,1)=cos(m*2*pi/N);
%     position(m,2)=sin(m*2*pi/N);
% end
% 
% %����N����
% plot(position(:,1),position(:,2),'o')
% hold on
% for i=1:N
%     for j=i:N
%         if(connection(i,j) == 1)
%             plot(position([i,j],1),position([i,j],2));
%         end
%     end
% end
