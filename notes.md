## When Changed (like Guard)
https://github.com/joh/when-changed
```bash
when-changed solution.rb 'clear && ruby %f'
```

## CURL the input
```bash
year=`date +%Y`;day=`date +%-d`;curl -H "cookie: session=${AOC_SESSION}" https://adventofcode.com/$year/day/$day/input > input.txt
```

### CURL the input - my function
```bash
aocinput
```
