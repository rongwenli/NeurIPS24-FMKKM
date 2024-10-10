function DBI = davies_bouldin_index(data, cluster_assignments, cluster_centers)
% Function: davies_bouldin_index
%
% Usage:
%    DBI = davies_bouldin_index(data, cluster_assignments, cluster_centers)
%
% Description:
%    The davies_bouldin_index function calculates the Davies-Bouldin Index (DBI), a metric used to evaluate the quality of clustering.
%
% Inputs:
%    - data: Matrix where each row represents a data point.
%    - cluster_assignments: Vector specifying the cluster assignment for each data point.
%    - cluster_centers: Matrix where each row represents the center of a cluster.
%
% Outputs:
%    - DBI: Davies-Bouldin Index, a measure of clustering quality. Lower values indicate better clustering.
%
% Algorithm Description:
%    1. For each cluster in your clustering solution:
%       - Calculate the average distance between each data point in the cluster and the centroid (center) of that cluster.
%
%    2. For each pair of clusters (i and j):
%       - Calculate the average distance between the centroids of cluster i and cluster j.
%
%    3. For each cluster i, compute the Davies-Bouldin Index (DBI) as follows:
%       - Find the cluster j (j ≠ i) that has the highest similarity (lowest average distance) with cluster i.
%       - Calculate the ratio of the sum of the average distances within cluster i and cluster j to the average distance between their centroids.
%         DBI(i) = (avg_distance_i + avg_distance_j) / distance_between_centroids(i, j)
%
%    4. Finally, the Davies-Bouldin Index (DBI) is the average of all DBI values for each cluster:
%       DBI = (1 / num_clusters) * ∑(DBI(i) for i = 1 to num_clusters)
%
% Author: OpenAI (Adapted from the original DBI concept by D.L. Davies and D.W. Bouldin in 1979)
%
% Example Usage:
%    % Assuming data, cluster_assignments, and cluster_centers are defined:
%    DBI = davies_bouldin_index(data, cluster_assignments, cluster_centers);
%
    num_clusters = max(cluster_assignments);
    cluster_distances = zeros(1, num_clusters);

    for i = 1:num_clusters
        % Calculate the average distance from points in cluster i to the center of cluster i
        cluster_points = data(cluster_assignments == i, :);
        cluster_center = cluster_centers(i, :);
        avg_distance_i = mean(pdist2(cluster_points, cluster_center));
        
        % Calculate the distances from cluster i to all other clusters
        for j = 1:num_clusters
            if i ~= j
                % Calculate the average distance from points in cluster i to the center of cluster j
                cluster_j_points = data(cluster_assignments == j, :);
                cluster_j_center = cluster_centers(j, :);
                avg_distance_ij = mean(pdist2(cluster_points, cluster_j_center));
                
                % Store the maximum ratio of (avg_distance_i + avg_distance_j) / avg_distance_ij
                cluster_distances(i) = max(cluster_distances(i), (avg_distance_i + avg_distance_j) / avg_distance_ij);
            end
        end
    end

    % Davies-Bouldin Index is the average of cluster_distances
    DBI = mean(cluster_distances);
end
