import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
import random


def creat_matrix(nodes, degree):
    connection = np.zeros((nodes, nodes), dtype = 'i1')

    for offset in range(1, int(degree/2)+1):
        for row in range(nodes):
            connection[row, (row+offset)%nodes] = 1
            connection[(row+offset)%nodes, row] = 1

    # print(connection)
    return connection

def reconnect(matrix, p):
    for row in range(len(matrix)-1):
        for column in range(row+1, len(matrix)):
            if(connection[row, column] == 1):
                if(random.random() < p):
                    connection[row, column] = 0
                    connection[column, row] = 0

                    while True:
                        new_connect = random.randint(0,len(matrix)-1)
                        if(new_connect != row) and (connection[row, new_connect] == 0):
                            connection[row, new_connect] = 1
                            connection[new_connect, row] = 1
                            # print(row,',',column,"->",row,',',new_connect)
                            break
    return matrix

def create_graph(matrix):
    graph = nx.Graph()#创建空的网络图

    graph.add_nodes_from(range(len(matrix)))

    for row in range(len(matrix)):
        for column in range(row+1, N):
            if(connection[row, column] == 1):
                graph.add_edge(row, column)

    return graph


N = 100
degree = 4
break_p = 0.5

# connection = creat_matrix(N, degree)
# # print(connection)

# reconnection = reconnect(connection, break_p)
# # print(C)

# G = create_graph(reconnection)

D_buf = []
C_buf = []

p_buf = [0,0.0001,0.00025,0.0005,0.001,0.002,0.004,0.008,0.018,0.03,0.065,0.13,0.25,0.5]
for i in p_buf:
    # break_p = float(i/200)
    connection = creat_matrix(N, degree)
    reconnection = reconnect(connection, i)
    G = create_graph(reconnection)

    D_buf.append(nx.average_shortest_path_length(G))
    C_buf.append(nx.average_clustering(G))
    print(i)

plt.plot(range(14), D_buf, color = 'red')
plt.plot(range(14), C_buf, color = 'blue')

plt.show()
# pos = nx.circular_layout(G)
# nx.draw_networkx_nodes(G, pos, node_size=10)
# nx.draw_networkx_edges(G, pos)
# # nx.draw_networkx_labels(G, pos)

# plt.show()



# nx.write_gexf(G,'your_file_name.gexf')


