clc;
clear;

p = power(10,(-4:0.1:0));

[c_0 d_0] = calculate(0);

buf = zeros(2, length(p));

for i = 1:length(p)
    i
    repeat = 50;
    average_buf = zeros(2,repeat);
    for j = 1:repeat
         [average_buf(1,j) average_buf(2,j)]= calculate(p(i));
    end
     buf(:,i)= mean(average_buf,2);
end

buf_normalized(1,:) = buf(1,:)/c_0;
buf_normalized(2,:) = buf(2,:)/d_0;


title('平均最短路径和集聚系数随重连概率的变化');
semilogx(p, buf_normalized','*');
xlim([0 1.1]);
ylim([0 1.1]);
legend('C(p)/C(0)','D(p)/D(0)');
set(gca,'xticklabel',get(gca,'xtick'));
xlabel('重连概率 p');

