n = read("input.txt");

MRfac(n, k) = {
  my(s, d);
  x = Mod(2, n);
  for(i=1, k, a = Mod(random(n - 2) + 2, n);
    s = valuation(n-1, 2);
    x = Mod(a, n)^(n >> s);
    if(lift(x) == 1 || lift(x) == n - 1, continue);
    for(j = 1, s - 1, y = x^2; if(lift(y)==1, return(gcd(x-1, n))); x = y; if(lift(x) == n -1, continue));
    return 1;
  );
  return 0;
}

print(lift(MRfac(n, 100000)));
