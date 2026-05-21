#import "mldisplay.typ": mldisplay
#import "lib.typ": ieee

#show: ieee.with(
  title: [Diseño de un lenguaje],
  summary: [
    Este informe narra la investigación, decisiones tomadas y problemas
    abordados a la hora de diseñar un lenguaje de programación.
  ],
  authors: (
    (
      name: "Hugo Coto",
      department: [Independent Researcher],
      location: [Santiago de Compostela, España],
      email: "hugo@hugocoto.com",
    ),
  ),
  index-terms: none,
  bibliography: bibliography("refs.bib"),
  paper-size: "us-letter",
  lang: "en",
  date: mldisplay(datetime.today(), "[weekday repr:long], [day] of [month repr:long] [year]"),
  aside: [Language designed and written by Hugo Coto Flórez],
)

= Introduction


= From functions to parameterized scopes

If I can do this,

```
a := (Int a, Int b) {
  Ret a + b
}
```

I want to be able to do this

```
result := (int a, int b) {
  Ret a + b
}(2,3)
```

and this is not different from defining a and b inside of the scope, and assign
values to they.

= persistent scopes

all scopes are persistent. They can accept input parameters

```
a := (Int i, Int j) {
  Int j := 0
  a i + yield i + j, j 
}

a
```
