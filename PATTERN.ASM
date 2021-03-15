; "Pattern", Atari XL/XE Intro 64B
; (63 bytes of code + 6 bytes of header)
; code by tr1x / Agenda
; requirements: original Atari XL/XE 64KB PAL
; version: 1.0
; release date: 2021-03-14

rowcrs	equ $0054
colcrs	equ $0055
color2	equ $02c6
color4	equ $02c8
atachr	equ $02fb
audf1	equ $d200
audc1	equ $d201
osgraph	equ $ef9c
ospoint	equ $f1d8


	org $0080

start
	; enter graphics mode
	lda #$09
	jsr osgraph
	sty color2		; Y should be 1 at this point

	lda #$ef
	sta audc1

loop1	lda #$4f
	sta colcrs
loop2	lda rowcrs
	lsr
	lsr
	tay

	; lame multiplication, but short code
	lda #$00
loop3	clc
	adc colcrs
	dey
	bne loop3

opcod1	and #$03
	sta atachr
	jsr ospoint
	dec rowcrs
	sta audf1		; let's play techno music!
	bne loop2
	dec colcrs
	bpl loop2

	lda #$10
	clc			; not necessary
	adc color4
	sta color4

	sec
	rol opcod1+1

	bne loop1		; inifinity loop

	;run start