#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
damerau_levenshtein(const char *a, const char *b)
{
        if (!strcmp(a, b)) return 0;
        if (!*a) return strlen(b);
        if (!*b) return strlen(a);

        int la = strlen(a);
        int lb = strlen(b);
        int last_row[256] = { 0 };
        int *d = calloc((lb + 2) * (la + 2), sizeof(int));
        if (!d) return -1;

        int max_dist = la + lb;

#define at(x, y) [(x) * (lb + 2) + (y)]

        d at(0, 0) = max_dist;

        for (int i = 0; i <= la; i++) {
                d at(i + 1, 0) = max_dist;
                d at(i + 1, 1) = i;
        }

        for (int j = 0; j <= lb; j++) {
                d at(0, j + 1) = max_dist;
                d at(1, j + 1) = j;
        }

        for (int i = 1; i <= la; i++) {
                int last_col = 0;
                for (int j = 1; j <= lb; j++) {
                        int i1 = last_row[(unsigned char) b[j - 1]];
                        int j1 = last_col;
                        int cost = a[i - 1] == b[j - 1] ? 0 : 1;
                        if (cost == 0) last_col = j;

                        int r = d at(i, j) + cost;
                        int s = d at(i + 1, j) + 1;
                        int t = d at(i, j + 1) + 1;
                        int u = d at(i1, j1) + (i - i1 - 1) + 1 + (j - j1 - 1);

                        d at(i + 1, j + 1) = r;
                        if (s < d at(i + 1, j + 1)) d at(i + 1, j + 1) = s;
                        if (t < d at(i + 1, j + 1)) d at(i + 1, j + 1) = t;
                        if (u < d at(i + 1, j + 1)) d at(i + 1, j + 1) = u;
                }
                last_row[(unsigned char) a[i - 1]] = i;
        }

        int result = d at(la + 1, lb + 1);
        free(d);
        return result;

#undef at
}

// Returns NULL or the closest one from keywords
const char *
suggest(const char *token, const char **kwords, int kwords_len)
{
        const int max_dist = 2; // limit worst suggestion
        const char *best_match = NULL;
        int best_dist = max_dist + 1;

        int tlen = strlen(token);
        if (tlen < 2) return NULL;

        for (int i = 0; i < kwords_len; i++) {
                // token is correct
                if (strcmp(token, kwords[i]) == 0) return NULL;

                // Fast prune: length gap alone exceeds budget
                if (abs(tlen - (int) strlen(kwords[i])) > max_dist) continue;

                int dist = damerau_levenshtein(token, kwords[i]);
                if (dist < 0) return NULL;

                if (dist < best_dist) {
                        best_dist = dist;
                        best_match = kwords[i];
                }
        }
        return best_match; // null if nothing was close enough
}

int
main(int argc, char **argv)
{
        char *a = "helo";
        const char **b = (const char *[]) { "something", "hello", "world" };
        const char *c = suggest(a, b, 3);
        printf("Suggestion: %s -> %s\n", a, c);
}
