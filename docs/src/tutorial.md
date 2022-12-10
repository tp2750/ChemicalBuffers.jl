# ChemicalBuffers Tutorial

In this example, we make 1 L of a 100 mM Phosphate buffer at pH 6.0 using 1 M stock solutions.

## Generate the stock solutions

Below we generate a 100 mM phospahte buffer with a pH of 6.0 at 25C.

```julia
using ChemicalBuffers
phos = buffer("Phosphate");
phos_stock = buffer_stocks(phos, M = 1.0);
phos_100_6.0 = buffer(phos_stock, pH = 6.0, M = 0.1, T=25);
```

## Printing recipe

We can print recipies using the `print_recipe` function. Below we make 1 L:

```julia
print_recipe(phos_100_6.0, L = 1.0)
```

## 1 L 100 mM pH 6.0 Phosphate Buffer

### Stock Solutions

* 1 M Monosodium phosphate
* 1 M Disodium phosphate

### 1 L 100 mM pH 6.0 Phosphate buffer

| Stock solution           | volume (mL) | Notes                                                                                        |
| ---                      | ---         | ---                                                                                          |
| 1 M Monosodium phosphate | 86.47       | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1 M Disodium phosphate   | 13.53       | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| H2O                      | 900         |                                                                                              |


## Printing recipe of stock solution

We prepare 1 L of each of the stocks:

```julia
print_recipe(phos_stock, L = 1.0)
```

### 1 L 1 M Phosphate buffer stock solutions

| Stock Solution             | Salt                              | CAS        | weigth (g) | H2O (mL) | MW (g/mol) | Formula      | Notes                                                                                        |
| ---                        | ---                               | ---        | ---        | ---      | ---        | ---          | ---                                                                                              |
| 1L 1M Monosodium phosphate | Monosodium phosphate, monohydrate | 10049-21-5 | 137.99     | 1000     | 137.99     | NaH2PO4·H2O  | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Disodium phosphate   | Disodium phosphate, heptahydrate  | 7782-85-6  | 268.07     | 1000     | 268.07     | Na2HPO4·7H2O | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |

# Hydration

We can explore other hydration options for the salts using an option:

```julia
print_recipe(phos_stock, all_hydrates=true)
```

## Stock Solutions Phosphate buffer

### 1L 1M Monosodium phosphate

| Stock Solution             | Salt                              | CAS        | weigth (g) | H2O (mL) | MW (g/mol) | Formula      | Notes                                                                                        |
| ---                        | ---                               | ---        | ---        | ---      | ---        | ---          | ---                                                                                          |
| 1L 1M Monosodium phosphate | Monosodium phosphate, anhydrate   | 7558-80-7  | 119.98     | 1000     | 119.98     | NaH2PO4      | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Monosodium phosphate | Monosodium phosphate, monohydrate | 10049-21-5 | 137.99     | 1000     | 137.99     | NaH2PO4·H2O  | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Monosodium phosphate | Monosodium phosphate, dihydrate   | 13472-35-0 | 156.01     | 1000     | 156.01     | NaH2PO4·2H2O | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |



### 1L 1M Disodium phosphate
| Stock Solution           | Salt                              | CAS        | weigth (g) | H2O (mL) | MW (g/mol) | Formula       | Notes                                                                                        |
| ---                      | ---                               | ---        | ---        | ---      | ---        | ---           | ---                                                                                          |
| 1L 1M Disodium phosphate | Disodium phosphate, anhydrate     | 7558-79-4  | 141.96     | 1000     | 141.96     | Na2HPO4       | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Disodium phosphate | Disodium phosphate, dihydrate     | 10028-24-7 | 177.99     | 1000     | 177.99     | Na2HPO4·2H2O  | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Disodium phosphate | Disodium phosphate, heptahydrate  | 7782-85-6  | 268.07     | 1000     | 268.07     | Na2HPO4·7H2O  | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Disodium phosphate | Disodium phosphate, dodecahydrate | 10039-32-4 | 358.14     | 1000     | 358.14     | Na2HPO4·12H2O | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |


When we have chosen the one we want, we can print the recipe to use:


```julia
print_recipe(phos_stock, hydrates = [0,0], L = 1.0)
```

### 1 L 1 M Phosphate buffer stock solutions

| Stock Solution             | Salt                            | CAS       | weigth (g) | H2O (mL) | MW (g/mol) | Formula | Notes                                                                                        |
| ---                        | ---                             | ---       | ---        | ---      | ---        | ---     | ---                                                                                          |
| 1L 1M Monosodium phosphate | Monosodium phosphate, anhydrate | 7558-80-7 | 119.98     | 1000     | 119.98     | NaH2PO4 | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
| 1L 1M Disodium phosphate   | Disodium phosphate, anhydrate   | 7558-79-4 | 141.96     | 1000     | 141.96     | Na2HPO4 | **WARNIG! H290: May be corrosive to metals, H314: Casuses severe skin burns and eye damage** |
	
