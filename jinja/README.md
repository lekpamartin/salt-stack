

# Variable

##Default value
if a args.var1 exist
```bash
{% set var = args.var1 or "TEST"  %}
```
if a args.var1 exist or not. set default for var2 if args.var2 if empty
```bash
{% set var = args.var1|default("TEST")  %}
{% set var2 = args.var2|default("TEST", true)  %}
```
