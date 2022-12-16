import random
import numpy as np
import time
# Fonction qui calcule le coût total
def cout_total(cost_ring, cost_star, ring, star_matrice):
  N = len(cost_ring)

  cout_ring = 0
  cout_star = 0

  # Coût du ring
  for i in range(len(ring) - 1):
     cout_ring += cost_ring[ring[i+1], ring[i]]
  cout_ring += cost_ring[ring[0], ring[-1]]

  # Coût des stars
  for i in range(N):
    for j in ring:
      if star_matrice[i,j] == 1:
        cout_star += cost_star[j,i]

  cout_total = cout_star + cout_ring
  return cout_total



# Fonction qui calcule le coût du ring
def cout_ring(ring, cost_ring):
  # Coût du ring
  cout = 0
  for i in range(len(ring) - 1):
     cout += cost_ring[ring[i+1], ring[i]]
  cout += cost_ring[ring[0], ring[-1]]

  return cout



def ajout(cost_ring, cost_star, ring, star_matrice, star):
    if len(ring) == len(star_matrice) :
        return ring, star_matrice, star
    print("ajout")
    N = len(star)
    num = random.randint(1, N)
    elem_star = star[num - 1]
    # ajout
    ring.append(elem_star)
    del star[num - 1]
    star_matrice = assignement(star, cost_star, ring)

    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    best_valeur = cout_ring(ring, cost_ring)

    # on conserve la meilleure ring
    for i in range(len(ring) - 1):
        new_ring = v1_permut(ring, i, len(ring))

        new_val = cout(cost_ring, cost_star, new_ring, star_matrice)
        if new_val < best_valeur:
            best_ring = new_ring
            best_valeur = new_val

    return best_ring, best_star_mat, best_star

def extrait_star(centre_star, listestar):
  elem_star = []
  N = len(listestar)
  for i in range(1, N + 1):
    if listestar[i, centre_star] == 1:
      elem_star.append(i)
  return elem_star


def assignement(star, cost_star, ring):
    N = len(cost_star)

    star_matrice = np.zeros((N, N))
    for i in star:
        minval, idx = min(enumerate(cost_star[i, ring]), key=lambda x: x[1])
        star_matrice[i, ring[idx]] = 1

    return star_matrice


def v1_permut(ring, num1, num2):
  temp = ring[num1]
  ring[num1] = ring[num2]
  ring[num2] = temp

  return ring

def cout(cost_ring, cost_star, ring, star_matrice):
  N = len(cost_ring)

  cout_ring = 0
  cout_star = 0

  # cout du ring
  for i in range(1, len(ring)):
    cout_ring += cost_ring[ring[i], ring[i - 1]]
  cout_ring += cost_ring[ring[0], ring[-1]]

  # cout des stars
  for i in range(N):
    for j in ring:
      if star_matrice[i, j] == 1:
        cout_star += cost_star[j, i]

  cout_total = cout_star + cout_ring
  return cout_total


def echange(cost_ring, cost_star, ring, star_matrice, star):
    N = len(star)
    num = random.randint(1, N)
    elem_star = star[num - 1]
    centre_star = np.where(star_matrice[elem_star, :] == 1)
    idx_centre = np.where(ring == centre_star)
    new_ring = ring
    new_ring[idx_centre] = elem_star
    new_star = star

    del new_star[num - 1]
    new_star.append(centre_star)
    newstar_matrice = assignement(new_star, cost_star, new_ring)

    return new_ring, newstar_matrice, new_star







def ini_min_somme(cost_ring, cost_star):
    N = len(cost_ring)
    ring = []
    star = []
    star_matrice = np.zeros((N, N))
    for i in range(1, N + 1):
        if random.random() < 0.5:
            ring.append(i)
        else:
            star.append(i)

    star_matrice = assignement(star, cost_star, ring)

    return ring, star_matrice, star

def supression(cost_ring, cost_star, ring, star_matrice, star):
    if len(ring) < 2 :
        return ring, star_matrice, star
    N = len(ring)
    num = random.randint(1, N)

    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    best_valeur = float("inf")
    centre_star = ring[num - 1]
    elem_star = extrait_star(centre_star, star_matrice)

    # supression
    new_ring = ring
    del new_ring[num - 1]
    new_star = star
    new_star.append(centre_star)
    newstar_matrice = assignement(new_star, cost_star, new_ring)
    new_val = cout(cost_ring, cost_star, new_ring, newstar_matrice)
    if new_val < best_valeur:
        print("suppression")
        best_ring = new_ring
        best_star = new_star
        best_star_mat = newstar_matrice
        best_valeur = new_val

    return best_ring, best_star_mat, best_star


def verif(ring, star_matrice, star, M):
    N = len(star_matrice)
    if N != M:
        print("La star matrice n'a pas la bonne taille")
    if len(ring) + len(star) != M:
        print("star et ring n ont pas la bonne taille")

    for i in range(1, N + 1):
        if i in ring:
            if i in star:
                print("Cet élément est dans le ring et star"), print(i)
            else:
                if not (star_matrice[i, :] == np.zeros((1, N))).all():
                    print("la ligne de la matrice n'est pas correcte"), print(i)
        elif len(np.where(ring == i)[0]) > 1:
            print("Cet élément est plusieus fois dans ring"), print(i)
        elif len(np.where(star == i)[0]) > 1:
            print("Cet élément est plusieus fois dans star"), print(i)
        elif i in star:
            if len(np.where(star_matrice[i, :] == 1)[0]) > 0:
                idx = np.where(star_matrice[i, :] == 1)[0]
                if idx in ring:
                    continue
                else:
                    print("pas attribué à un ring"), print(i)
            else:
                print("l'élément n'est pas attribué"), print(i)
        else:
            print("Il manque l'élément"), print(i)

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
          r = random.randint(1,len(options))
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


def Recuit_variable(cost_ring, cost_star, ring, star_matrice, star):
    # initialisation
    print("recuit")
    N = len(star_matrice)
    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    valeur = cout(cost_ring, cost_star, best_ring, best_star_mat)
    best_valeur = valeur
    t = 0
    itt = 1
    N = len(cost_ring)
    t = 0

    # paramètre du recuit simulé
    pi = 0.8
    pallier = 4 * N ** 1.5
    facteurT = 0.9

    # recherche de la température
    ecart_type = 0
    for i in ring:
        ecart_type += np.std(cost_ring[ring, i])
    ecart_type /= len(ring)
    Ti = -ecart_type / np.log(pi)
    T = Ti

    while t < 60:
        itt = 1
        fige = True
        while t < 3 * 60 and itt <= pallier:
            k = np.randint(3) + 1

            if k % 4 == 0:
                print("a")
                new_ring, new_star_matrice, new_star, new_valeur = ajout(cost_ring, cost_star, ring, star_matrice, star)
            elif k % 4 == 1:
                print("p")
                #new_ring, new_star_matrice, new_star, new_valeur = permutation(cost_ring, cost_star, ring, star_matrice,star)
            elif k % 4 == 2:
                print("e")
                new_ring, new_star_matrice, new_star, new_valeur = echange(cost_ring, cost_star, ring, star_matrice,star)
            else:
                print("s")
                new_ring, new_star_matrice, new_star, new_valeur = supression(cost_ring, cost_star, ring, star_matrice,star)

            # Evaluation si changement
            if new_valeur <= valeur:
                # on garde le changement
                ring = new_ring
                valeur = new_valeur
                star = new_star
                star_matrice = new_star_matrice

                fige = False
            else:
                deltaE = new_valeur - valeur
                p = np.exp(-deltaE / T)
                nbre = random()
                if nbre <= p:  # on garde le changement
                    ring = new_ring
                    valeur = new_valeur
                    star = new_star
                    star_matrice = new_star_matrice
                    fige = False

            # mise à jour de la nouvelle meilleure valeur
            if new_valeur < best_valeur:
                best_ring = new_ring
                best_valeur = new_valeur
                best_star = new



# Initialisation ----------------

fileName = "instances/instance1.txt"

with open(fileName,'r') as fin :
    N = int(fin.readline())

    cost_ring = []
    cost_star = []
    for i in range(N) :
        b = fin.read(1) # pour enlever le premier caractére qui est un espace
        cost_ring.append([int(a) for a in fin.readline().rstrip().split(" ")])

    for i in range(N):
        b = fin.read(1)  # pour enlever le premier caractére qui est un espace
        cost_star.append([int(a) for a in fin.readline().rstrip().split(" ")])

# Solution initiale  --------------------------

# initialisation aleatoire
alpha = 0.1
ring, star_matrice, star, sol = grasp1(cost_ring, cost_star, 60)

# Algorithme --------------------------

#ring, star_matrice, star = recuit_variable(cost_ring, cost_star, ring, star_matrice, star)
#[ring ,star_matrice,star]=recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, 10);
#[ring ,star_matrice,star]=fourmis(cost_ring, cost_star, ring, star_matrice, star);

# Verification de la solution  --------------------------

verif(ring, star_matrice, star)

# Calcul du Cost ----------------

cout_total = cout(cost_ring, cost_star, ring, star_matrice)

# Output ------------------------

# faire la transition

##dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
##dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");

