# Programa para generar la serie Fibonacci y calcular la suma de los números

.data
prompt_fib:      .asciiz "¿Cuántos números de la serie Fibonacci quiere generar?: "
fibo_msg:        .asciiz "Los primeros números de la serie Fibonacci son: "
sum_msg:         .asciiz "La suma de la serie es: "

.text
.globl main

main:
    # Se pregunta al usuario cuántos números de Fibonacci desea generar
    li $v0, 4               # syscall para imprimir string
    la $a0, prompt_fib       # cargar el mensaje
    syscall
    
    li $v0, 5               # syscall para leer un entero
    syscall
    move $t0, $v0           # almacenar el número de elementos de Fibonacci en $t0
    
    # Se inicializan los primeros valores de la serie
    li $t1, 0               # primer número de la serie (0)
    li $t2, 1               # segundo número de la serie (1)
    li $t3, 0               # contador de la serie
    li $t4, 0               # acumulador para la suma
    
    # Se muestra el mensaje inicial
    li $v0, 4               # syscall para imprimir string
    la $a0, fibo_msg         # cargar el mensaje de Fibonacci
    syscall
    
fibo_loop:
    # Se imprime el número actual de la serie (t1)
    li $v0, 1               # syscall para imprimir entero
    move $a0, $t1           # pasar el número de Fibonacci actual
    syscall
    
    # Se suman el número actual al acumulador
    add $t4, $t4, $t1
    
    # Se calculan el siguiente número de la serie
    add $t5, $t1, $t2       # siguiente número = t1 + t2
    move $t1, $t2           # mover el segundo número al primer lugar
    move $t2, $t5           # mover el nuevo número a t2
    
    # Se incrementa el contador
    addi $t3, $t3, 1
    bge $t3, $t0, fibo_end  # si hemos generado suficientes números, salir del bucle
    j fibo_loop             # repetir el bucle
    
fibo_end:
    # Se muestra la suma de la serie
    li $v0, 4               # syscall para imprimir string
    la $a0, sum_msg          # cargar el mensaje de la suma
    syscall
    
    li $v0, 1               # syscall para imprimir entero
    move $a0, $t4           # pasar la suma acumulada
    syscall
    
    li $v0, 10              # salir del programa
    syscall
