# Programa para encontrar el número menor de una lista entre 3 y 5 números, el programa evalua el rango de entrada digitado

.data
prompt_num:      .asciiz "¿Cuántos números quiere comparar? (min 3, max 5): "
invalid_msg:     .asciiz "Error: Ingrese un número entre 3 y 5.\n"
input_prompt:    .asciiz "Ingrese un número: "
result_msg:      .asciiz "El número menor es: "

.text
.globl main

main:
    # Preguntar al usuario cuántos números va a ingresar
    li $v0, 4               # syscall para imprimir string
    la $a0, prompt_num       # cargar la dirección del mensaje
    syscall
    
    li $v0, 5               # syscall para leer un entero
    syscall
    move $t0, $v0           # almacenar el número ingresado en $t0
    
    # Evaluar que el número ingresado esté entre 3 y 5
    li $t1, 3               # valor mínimo permitido
    li $t2, 5               # valor máximo permitido
    blt $t0, $t1, error     # si el número es menor que 3, ir a error
    bgt $t0, $t2, error     # si el número es mayor que 5, ir a error

    # Inicializar el contador y el valor menor
    li $t3, 0               # contador de números
    li $t4, 2147483647      # valor inicial del número menor (máximo entero)
    
input_loop:
    # Se solicita al usuario ingresar un número
    li $v0, 4               # syscall para imprimir
    la $a0, input_prompt     # cargar el mensaje de "Ingrese un número"
    syscall
    
    li $v0, 5               # syscall para leer un entero
    syscall
    move $t5, $v0           # almacenar el número ingresado en $t5
    
    # Comparar si el número ingresado es menor al actual menor
    bge $t5, $t4, skip      # si el número ingresado es mayor o igual al actual menor, saltar
    move $t4, $t5           # si es menor, actualizar el menor
    
skip:
    addi $t3, $t3, 1        # incrementar el contador
    bge $t3, $t0, finish    # si se ingresaron suficientes números, terminar el bucle
    j input_loop            # repetir el bucle
    
finish:
    # Mostrar el resultado (el número menor)
    li $v0, 4               # syscall para imprimir
    la $a0, result_msg       # cargar el mensaje de "El número menor es:"
    syscall
    
    li $v0, 1               # syscall para imprimir entero
    move $a0, $t4           # pasar el menor encontrado a $a0
    syscall
    
    li $v0, 10              # salir del programa
    syscall

error:
    # Si el número de entradas es inválido, mostrar un mensaje de error
    li $v0, 4               # syscall para imprimir string
    la $a0, invalid_msg      # cargar el mensaje de error
    syscall
    
    li $v0, 10              # salir del programa
    syscall
