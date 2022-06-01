#!/bin/bash

# colores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# contador
tests_passed=0

# funciones
test_output() {
  output=$($1)
  expected=$2
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 → $2 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_spim() {
  output=$(echo $1 | $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: echo $1 | $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_redirect() {
  output=$($1 < $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 < $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}

# 1 suma
test_output_redirect "spim -q -f suma.s" "tests/90.txt" "90"
test_output_redirect "spim -q -f suma.s" "tests/7.txt" "7"
test_output_redirect "spim -q -f suma.s" "tests/100.txt" "100"
test_output_redirect "spim -q -f suma.s" "tests/12.txt" "12"
test_output_redirect "spim -q -f suma.s" "tests/36.txt" "36"
test_output_redirect "spim -q -f suma.s" "tests/15.txt" "15"
test_output_redirect "spim -q -f suma.s" "tests/5.txt" "5"
test_output_redirect "spim -q -f suma.s" "tests/0.txt" "0"
test_output_redirect "spim -q -f suma.s" "tests/1.txt" "1"
test_output_redirect "spim -q -f suma.s" "tests/20.txt" "20"
# 2 iguales
test_output "spim -q -f iguales.s 1 1 1" "iguales"
test_output "spim -q -f iguales.s 1 1 2" "no iguales"
test_output "spim -q -f iguales.s 1 3 4" "no iguales"
test_output "spim -q -f iguales.s 1 2 1" "no iguales"
test_output "spim -q -f iguales.s -1 -1 -1" "iguales"
test_output "spim -q -f iguales.s 4 4 4" "iguales"
test_output "spim -q -f iguales.s -10 9 -3" "no iguales"
test_output "spim -q -f iguales.s 10 10 10" "iguales"
test_output "spim -q -f iguales.s 1 2 3" "no iguales"
test_output "spim -q -f iguales.s 1234 1234 1234" "iguales"

# resultado final
echo "--------------  Resultado  --------------"
if [[ $tests_passed -eq 20 ]]
then
  echo -e "Todos los tests pasaron ${GREEN}✓${NC}"
else
  echo "Resultado: $tests_passed/20 tests OK."
fi

exit 0
