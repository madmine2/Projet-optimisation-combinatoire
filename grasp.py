from utils import *
# Fonction qui calcule le coût total

def grasp1(cost_ring, cost_star,times):
  start = time.perf_counter()
  N = len(cost_ring)
  best_ring = []
  best_star = []
  best_star_mat = np.random.rand(N,N)
  best_value = float("inf")

  ring = [1]
  star = []
  possible = list(range(2,N+1))
  p = 1
  t = 0
  k = 1
  x = 0
  bestsol = 0
  sol = []

  while t < times:
    for alpha in np.arange(0, 0.41, 0.01):
      ring = [1]
      star = []
      possible = list(range(1,N))

      while len(ring) + len(star) < N:
        maximum = 0
        minimum = float("inf")
        for i in possible:
          if cost_ring[p][i] > maximum:
            maximum = cost_ring[p][i]
          if cost_star[p][i] > maximum:
            maximum = cost_star[p][i]
          if cost_ring[p][i] < minimum:
            minimum = cost_ring[p][i]
          if cost_star[p][i] < minimum:
            minimum = cost_star[p][i]

        borne = minimum + (maximum - minimum) * alpha

        options = []
        counta = -1

        for i in possible:
          if cost_ring[p][i] <= borne:
            options.append(i)
            counta += 1

        for i in possible:
          if cost_star[p][i] <= borne:
            options.append(i)

        if len(options) > 1:
          r = random.randint(1,len(options)-1)
        else:
          r = 1

        for j in range(1,len(possible)):
          if j > len(possible):
            break
          if possible[j] == options[r]:
            possible[j] = []
            j -= 1

        if r < counta:
          ring.append(options[r])
          p = options[r]
        else:
          star.append(options[r])

      star_mat = assignement(star, cost_star, ring)
      verif(ring, star_mat, star, len(cost_ring))
      cout1 = cout(cost_ring, cost_star, ring, star_mat)

      if cout1 < best_value:
        best_ring = ring
        best_star = star
        best_star_mat = star_mat
        best_value = cout1

    end = time.perf_counter()
    t = end - start
