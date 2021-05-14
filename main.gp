n = read("input.txt");

/* D'après l'énoncé, l'entier n a passé le test de Miller-Rabin.
 * On va adapter l'algo de Miller-Rabin pour reconstituer un
 * facteur de n.
 * 
 * Si y = a^(d*2^j) mod n vaut 1, et que la valeur précédente de y est différente de 1, il s'ensuit que
 * y est une racine carré de 1, différente de 1 et -1.
 * Conclusion : n est composé, ce résultat n'étant pas possible pour n premier.
 * Puisque
 * - y = x^2 = 1 mod n, ie. n divise x^2 - 1 = (x - 1)(x + 1)
 * - x != ± 1 mod n implique que n ne divise pas x - 1 ou x + 1
 * il en découle que pgcd(x-1,n) et pgcd(x+1,n) sont des facteurs non triviaux de n.
 * n étant impair, ces derniers sont premiers entre-eux, donc n est leur produit.
 */
MRfac(n, threshold) = {
  my(s, d, i);
  x = Mod(2, n);
  i = 0;
  while(1,
    \\a = Mod(random(n - 2) + 2, n); \\ on peut rendre l'algo déterministe en itérant sur a, incrémenté à chaque fois
    a = Mod(random(threshold), n); \\ On tente de petites valeurs de a
    s = valuation(n - 1, 2);
    x = Mod(a, n)^(n >> s);
    if(lift(x) == 1 || lift(x) == n - 1, continue);
    for(j = 1, s - 1,
      y = x^2;
      if(lift(y) == 1,
        return( min(lift(gcd(x + 1, n)), lift(gcd(x - 1, n))) )  \\ on retourne le plus petit facteur
      );
      x = y;
      if(lift(x) == n - 1, continue)
    );
    return 1; \\ composé
  );
  return 0; \\ probablement premier
}

print(MRfac(n, 300));
