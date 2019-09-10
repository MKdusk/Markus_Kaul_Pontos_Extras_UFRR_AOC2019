.data
str: .asciiz "Informe um valor : "
.text
.globl main
main:
move $t0, 3 #Coloca o valor 3 no registrador temporario $t0
sw $t0, 0($s0) #Armazena o valor de $t0 na memoria = array[0]
move $t0, 2 #Coloca o valor 2 no registrador temporario $t0                           "
sw $t0, 4($s0) #Armazena o valor de $t0 na memoria = array[1]
move $t0, 5 #Coloca o valor 5 no registrador temporario $t0                           "
sw $t0, 8($s0) #Armazena o valor de $t0 na memoria = array[2]
move $t0, 1 #Coloca o valor 1 no registrador temporario $t0                           "
sw $t0, 12($s0) #Armazena o valor de $t0 na memoria = array[3]
move $s1, 13 #Coloca o valor 4 no registrador $s1
move $t0, 0
LOOP1: #primeiro for
	la $a0, str #$a0 recebe o endereço de str
	li $v0, 5 #lê um numero inteiro
	syscall
	sw $v0, $t0($s0) #Armazena o valor lido pelo usuario em $s0
	addi $t0,$t0,4 #Soma de 4 em 4 o registrador temporario 
	slt $t4,$t0,$s1 #Set on less than - que compara se o registrador $t0 é menor que o $s1. Caso verdadeiro seta o $t4 com 1 e caso falso com 0
	beq $t4,0,LOOP1 #Caso condição quebrada sai do loop
move $t1,0
LOOP2: #segundo for
	move $t2,0 #começando sempre com zero
	sub $s2,$s1,$t1 #Subtrai $s2 = $s1 - $t1 | $s2 = n - c
	LOOP3: #terceiro for
		lw $t0,$t2($s0) #$t2 = d
		addi $t5,$t2,4 #$t5 = d+1
		lw $t6,$t5($s0) #Recebe o valor de array[d+1]
		slt $t4,$t6,$t0 #Compara se $t6 é menor que $t0
		beq $t4,1,TROCA #se for verdadeiro ele realiza a troca
		bne $t4,1,COMPARACAO #se for verdadeiro ele realiza a proxima comparação (n-c-1) e incrementa (d++)
		TROCA:
			move $t3, $t6 #swap = array[d+1]
			sw $t6, $t2($s0) #Salva o novo valor | array[d] = array[d+1]
			sw $t3, $t5($s0) #Finaliza a troca | array[d+1] = swap
			j COMPARACAO #Pula para realizar a comparação (n-c-1) e incrementa(d++)
		COMPARACAO:
			addi $t2,$t2,4
			slt $t4,$t2,$s2
			beq $t4,1,LOOP3
	addi $t1,$t1,4
	slt $t4,$t1,$s1
	beq $t4,1,LOOP2