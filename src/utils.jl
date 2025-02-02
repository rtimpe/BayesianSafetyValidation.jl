"""
Convert vector of vectors to a matrix where the columns correspond to the sub-vectors.
"""
cmat(V) = [V[i][j] for j in 1:length(V[1]), i in 1:length(V)]


"""
Get argument that maximizes across 2D (x,y) space.
"""
function Base.argmax(X, Y, Z)
	z = argmax(Z).I
	return [X[z[2]], Y[z[1]], Z[z[1], z[2]]]
end


function create_gif(plots_dir, output_gif; delay=100, resize=20)
    frames = map(f->joinpath(plots_dir, f), split(read(`ls -v $plots_dir`, String)))
    run(`convert -delay $delay -loop 0 -resize $resize% $frames $output_gif`)
end


sigmoid(z; c=0, k=1) = 1 / (1 + exp(-(z-c)*k))


normalize01(X) = (X .- minimum(X)) / (maximum(X) - minimum(X))

# Exponential Smoothing (from Crux.jl)
function smooth(v, weight = 0.6)
    N = length(v)
    smoothed = Array{Float64, 1}(undef, N)
    smoothed[1] = v[1]
    for i = 2:N
        smoothed[i] = smoothed[i-1] * weight + (1 - weight) * v[i]
    end
    return smoothed
end